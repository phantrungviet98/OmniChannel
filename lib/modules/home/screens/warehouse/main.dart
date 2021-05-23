import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';

class WarehouseScreen extends BaseScreen {
  static final theme = ScreenTheme(
      color: AppColors.sage, title: 'Nhập kho', icon: Icons.move_to_inbox);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
        ],
      ),
    );
  }
}
