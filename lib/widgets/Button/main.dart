import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final String title;
  final bool loading;
  final Color color;

  AppButton({this.onPressed, this.child, this.title, this.loading, this.color});

  _onPress() {
    if (this.loading != null && loading == true) {
      return null;
    } else {
      this.onPressed();
    }
  }

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
    return ElevatedButton(
      onPressed: _onPress,
      child: _buildChild(),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => color)),
    );
  }
}
