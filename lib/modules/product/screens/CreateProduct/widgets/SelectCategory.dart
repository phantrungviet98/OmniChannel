import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';

class SelectCategory extends StatelessWidget {
  SelectCategory({this.onChange});
  final Function(Cats) onChange;

  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.pushNamed(context, '/select-category');
        this.onChange(result);
        _text.text = (result as Cats).name;
      },
      child: TextField(
        controller: _text,
        decoration: InputDecoration(
            hintText: 'Chọn danh mục',
            hintStyle:
            TextStyle(color: Colors.black)),
        enabled: false,
      ),
    );
  }
}