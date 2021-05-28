import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:omnichannel_flutter/assets/json/JsonAnimates.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/fonts/FontSize.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';

class SplashScreen extends BaseScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loading(),
    );
  }

}

class Loading extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoadingState();
  }
}

class _LoadingState extends State<Loading> {

  Future _init() async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.subscribeToTopic('all');
    final token = await messaging.getToken();
    log('Firebase token:' + token);

    FirebaseMessaging.onMessage.listen((event) {
      print('FirebaseMessaging.onMessage: ' + event.data.toString());
    });

    final message = messaging.getInitialMessage();
    log('getInitialMessage' + message.toString());
    Navigator.pushReplacementNamed(context, '/on-board');
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppTheme),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(JsonAnimates.loading),
          Text(
            'Ứng dụng đang được khởi tạo...',
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: FontSize.big),
          )
        ],
      ),
    );
  }
}
//
// class Error extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: AppColors.languidLavender),
//       child: Center(
//         child: Text(
//           'Có lỗi xảy ra!',
//           textDirection: TextDirection.ltr,
//           style: TextStyle(fontSize: FontSize.big),
//         ),
//       ),
//     );
//   }
// }

