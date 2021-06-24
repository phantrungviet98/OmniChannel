import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OneFieldLine extends StatefulWidget {
  const OneFieldLine(
      {this.hint, this.onChanged, this.initialValue = '', this.onSubmitted, this.isClearOnSubmit = false});

  final String hint;
  final Function(String) onChanged;
  final String initialValue;
  final Function(String) onSubmitted;
  final bool isClearOnSubmit;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<OneFieldLine> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _textController..text = widget.initialValue,
        decoration: InputDecoration(labelText: widget.hint),
        onChanged: (text) {
          widget.onChanged?.call(text);
        },
        onFieldSubmitted: (text) {
          if (widget.isClearOnSubmit) {
            _textController.clear();
          }
          return widget.onSubmitted(text);
        },
      ),
    );
  }
}
