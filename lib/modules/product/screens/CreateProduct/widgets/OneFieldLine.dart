import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OneFieldLine extends StatelessWidget {
  OneFieldLine(
      {this.hint, this.onChanged, this.onSubmitted, this.isClearOnSubmit = false});

  final String hint;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final bool isClearOnSubmit;

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(labelText: hint),
        onChanged: onChanged,
        onSubmitted: (text) {
          if (isClearOnSubmit) {
            _textController.clear();
          }
          return onSubmitted (text);
        },
      ),
    );
  }
}
