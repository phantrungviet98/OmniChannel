import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const languidLavender = Color.fromRGBO(224, 211, 222, 1);
  static const bone = Color.fromRGBO(216, 208, 193, 1);
  static const paleSilver = Color.fromRGBO(203, 184, 169, 1);
  static const sage = Color.fromRGBO(179, 180, 146, 1);
  static const dimGray = Color.fromRGBO(111, 104, 109, 1);
  static const sonicSilver = Color.fromRGBO(124, 118, 122, 1);
  static const taupeGray = Color.fromRGBO(136, 130, 134, 1);
  static const taupeGray2 = Color.fromRGBO(147, 141, 145, 1);
  static const spanishGray = Color.fromRGBO(157, 151, 155, 1);
  static const silverMetallic = Color.fromRGBO(166, 160, 164, 1);
}

const MaterialColor AppTheme = const MaterialColor(
  0xFFB3B492,
  const <int, Color>{
    50:  AppColors.languidLavender,
    100: AppColors.bone,
    200: AppColors.paleSilver,
    300: AppColors.sage,
    400: AppColors.dimGray,
    500: AppColors.sonicSilver,
    600: AppColors.taupeGray,
    700: AppColors.taupeGray2,
    800: AppColors.spanishGray,
    900: AppColors.silverMetallic,
  },
);