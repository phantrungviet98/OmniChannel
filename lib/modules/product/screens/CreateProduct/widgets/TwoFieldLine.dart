import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TwoFieldLine extends StatelessWidget {
  const TwoFieldLine({this.hint1, this.hint2, this.onChanged1, this.onChanged2});
  final String hint1;
  final String hint2;
  final Function(String) onChanged1;
  final Function(String) onChanged2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      labelText: hint1),
                  onChanged: onChanged1,
                ),
                padding: EdgeInsets.only(right: 4)),
          ),
          Expanded(
            child: Container(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      labelText: hint2),
                  onChanged: onChanged2,
                ),
                padding: EdgeInsets.only(right: 4)),
          )
        ],
      ),
    );
  }

}