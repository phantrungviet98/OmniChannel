import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';

showSnackBar(BuildContext context,
    {Color color = AppColors.taupeGray2, String text}) {
  final sb = SnackBar(
    backgroundColor: AppColors.taupeGray2,
    content: Text(text),
    duration: Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(sb);
}
