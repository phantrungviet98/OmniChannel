import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final String title;
  final bool loading;

  AppButton({this.onPressed, this.child, this.title, this.loading});

  _buildChild() {
    if (this.title != null) {
      return loading != null && loading == true
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Text(
              title,
              style: TextStyle(color: Colors.white),
            );
    } else {
      return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: _buildChild());
  }
}
