import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar with PreferredSizeWidget {
  @override
  get preferredSize => Size.fromHeight(50);

  CustomAppBar({Key key, String title, Color backgroundColor, List<Widget> actions})
      : super(
            key: key,
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: backgroundColor,
            actions: actions,
  );
}
