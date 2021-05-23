import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:omnichannel_flutter/assets/json/JsonAnimates.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';
import 'package:omnichannel_flutter/modules/home/screens/introduce/widgets/ConfigItem/main.dart';
import 'package:omnichannel_flutter/utis/ColorFromHex.dart';

class IntroduceScreen extends BaseScreen {
  static final theme = ScreenTheme(
      color: AppColors.sage, title: 'Tổng quan', icon: Icons.home);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return Column(
              children: [
                ConfigItem(
                  logo: Lottie.asset(JsonAnimates.settings),
                  title: '1. Cấu hình',
                  description: 'Cập nhật thông tin kho hàng của bạn',
                  buttonText: 'Cấu hình',
                  onPressed: () {},
                ),
                ConfigItem(
                  logo: Lottie.asset(JsonAnimates.update),
                  title: '2. Cập nhật sản phẩm',
                  description: 'Cập nhật thông tin sản phẩm và quản lý tồn kho',
                  buttonText: 'Cập nhật',
                  onPressed: () {},
                ),
                ConfigItem(
                  logo: Lottie.asset(JsonAnimates.money),
                  title: '3. Bán hàng',
                  description: 'Tạo đơn hàng và quản lý đơn hàng',
                  buttonText: 'Tạo ngay',
                  onPressed: () {},
                )
              ],
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}
