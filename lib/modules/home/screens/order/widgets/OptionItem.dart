import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final Function onPressed;

  OptionItem({this.icon, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.all(12)),
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: this.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text(title),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
