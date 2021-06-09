import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Location.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker(
      {this.status,
      this.hasError,
      this.code,
      this.hint,
      this.data,
      this.onChanged});

  final Status status;
  final bool hasError;
  final int code;
  final String hint;
  final List<Location> data;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: DropdownButton(
          icon: status == Status.loading ? Icon(Icons.sync) : null,
          isExpanded: true,
          value: code,
          onChanged: onChanged,
          hint: Text(hint,
              style: TextStyle(color: this.hasError ? Colors.red : null)),
          items: data
              .map((e) => DropdownMenuItem(value: e.id, child: Text(e.label)))
              .toList()),
    );
  }
}
