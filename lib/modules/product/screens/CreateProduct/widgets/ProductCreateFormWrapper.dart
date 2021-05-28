import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/utis/ui/Shadow.dart';

class ProductCreateFormWrapper extends StatelessWidget {
  const ProductCreateFormWrapper({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [Shadow.primary],
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: child);
  }
}
