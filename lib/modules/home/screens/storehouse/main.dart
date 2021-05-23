import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';

class StorehouseScreen extends BaseScreen {
  static final theme = ScreenTheme(
      color: AppColors.sage, title: 'Kho hàng', icon: Icons.storefront);

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
