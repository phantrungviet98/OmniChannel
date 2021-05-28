import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';
import 'package:omnichannel_flutter/modules/home/screens/export/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/introduce/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/more/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/order/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/product/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/transport/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/warehouse/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  var _widgetOptions = <Widget>[
    OrderScreen(),
    ProductScreen(),
    StorehouseScreen(),
    WarehouseScreen(),
    ExportScreen(),
  ];

  ScreenTheme _getThemeOnIndex() {
    switch (_selectedIndex) {
      case 0:
        {
          return OrderScreen.theme;
        }
      case 1:
        {
          return ProductScreen.theme;
        }
      case 2:
        {
          return StorehouseScreen.theme;
        }
      case 3:
        {
          return WarehouseScreen.theme;
        }
      case 4:
        {
          return ExportScreen.theme;
        }
      default:
        {
          return OrderScreen.theme;
        }
    }
  }

  Color _getIconColor(int index) {
    return _selectedIndex == index ? Colors.white : Colors.black;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _getBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(OrderScreen.theme.icon, color: _getIconColor(0)),
          label: OrderScreen.theme.title,
          backgroundColor: OrderScreen.theme.color),
      BottomNavigationBarItem(
          icon: Icon(ProductScreen.theme.icon, color: _getIconColor(1)),
          label: ProductScreen.theme.title,
          backgroundColor: ProductScreen.theme.color),
      BottomNavigationBarItem(
          icon: Icon(
            StorehouseScreen.theme.icon,
            color: _getIconColor(2),
          ),
          label: StorehouseScreen.theme.title,
          backgroundColor: StorehouseScreen.theme.color,
      ),
      BottomNavigationBarItem(
          icon: Icon(
            WarehouseScreen.theme.icon,
            color: _getIconColor(3),
          ),
          label: WarehouseScreen.theme.title,
          backgroundColor: WarehouseScreen.theme.color,
      ),
      BottomNavigationBarItem(
          icon: Icon(
            ExportScreen.theme.icon,
            color: _getIconColor(4),
          ),
          label: ExportScreen.theme.title,
          backgroundColor: ExportScreen.theme.color,
      )
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = _getThemeOnIndex();

    return Scaffold(
      appBar: _selectedIndex != 0
          ? CustomAppBar(
              title: theme.title,
              backgroundColor: theme.color,
            )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _getBottomNavigationBarItems(),
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}