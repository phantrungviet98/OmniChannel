import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';

class SelectCategory extends StatefulWidget {
  SelectCategory({this.onChange});
  final Function(Cats) onChange;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<SelectCategory> {
  String currentCateName = 'Chọn danh mục';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.pushNamed(context, '/select-category');
        widget.onChange(result);
        this.setState(() {
          currentCateName = (result as Cats).name;
        });
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(currentCateName), Icon(Icons.arrow_right)],
        ),
        padding: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: AppColors.sage))
        ),
      ),
    );
  }
}