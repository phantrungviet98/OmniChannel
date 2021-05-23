import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';

class MoreScreen extends BaseScreen {
  static final theme =
      ScreenTheme(color: AppColors.dimGray, title: 'Thêm', icon: Icons.more);

  @override
  Widget build(BuildContext context) {
    return Text(theme.title);
  }
}
