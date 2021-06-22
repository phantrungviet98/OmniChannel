import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:omnichannel_flutter/bloc-providers.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Account/AccountBloc.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginBloc.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/modules/auth/screens/login/main.dart';
import 'package:omnichannel_flutter/modules/auth/screens/onBoard/main.dart';
import 'package:omnichannel_flutter/modules/auth/screens/signUp/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/main.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/main.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductDescription/main.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductManagement/main.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductProperties/main.dart';
import 'package:omnichannel_flutter/modules/product/screens/SelectCategory/main.dart';
import 'package:omnichannel_flutter/modules/splash/screens/splash/main.dart';
import 'package:omnichannel_flutter/modules/stock/screens/CreateStockSuccess/CreateStockSuccessScreen.dart';
import 'package:omnichannel_flutter/modules/stock/screens/CreateUpdateStock/main.dart';
import 'package:page_transition/page_transition.dart';


import 'modules/home/screens/createExportScreen/createExportScreen.dart';
import 'modules/home/screens/createOrderScreen/createOrderScreen.dart';
import 'modules/home/screens/listOrderScreen/listOrderScreen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getBlocProviders(context),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: AppTheme,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/product-description':
              return PageTransition(
                child: ProductDescription(),
                type: PageTransitionType.bottomToTop,
                settings: settings,
              );
              break;
            case '/product-properties':
              return PageTransition(
                  child: ProductProperties(),
                  type: PageTransitionType.bottomToTop,
                  settings: settings);
              break;
            case '/create-update-stock':
              return PageTransition(
                  child: CreateUpdateStockScreen(),
                  type: PageTransitionType.bottomToTop,
                  settings: settings);
            case '/create-stock-success':
              return PageTransition(
                  child: CreateStockSuccessScreen(),
                  type: PageTransitionType.bottomToTop,
                  settings: settings);
            default:
              return null;
          }
        },
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/on-board': (context) => OnBoardScreen(),
          '/login': (context) => LoginScreen(),
          '/sign-up': (context) => SignUpScreen(),
          '/home': (context) => Home(),
          '/create-product': (context) => CreateProductScreen(),
          '/select-category': (context) => SelectCategoryScreen(),
          '/product-management': (context) => ProductManagementScreen(),
          '/createExport': (context) => createExportScreen(),
          '/createOrder': (context) => createOrderScreen(),
          '/listOrder': (context) => ListOrderScreen(),

        },
      ),
    );
  }
}
