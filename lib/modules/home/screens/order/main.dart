import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:omnichannel_flutter/assets/json/JsonAnimates.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/fonts/FontSize.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';
import 'package:omnichannel_flutter/modules/home/screens/order/widgets/OptionItem.dart';

class _Option {
  final Widget icon;
  final String title;
  final Function onPressed;

  _Option({this.icon, this.title, this.onPressed});
}

class OrderScreen extends BaseScreen {
  static final theme = ScreenTheme(
      color: AppColors.sage, title: 'Đơn hàng', icon: Icons.favorite_border_rounded);

  final List<_Option> _options = [
    _Option(
        icon: Icon(Icons.receipt),
        title: 'Danh sách đơn hàng',
        onPressed: () {}),
    _Option(
        icon: Icon(Icons.keyboard_return),
        title: 'Hàng trả lại',
        onPressed: () {}),
    _Option(
        icon: Icon(Icons.transfer_within_a_station),
        title: 'Quản lý giao hàng',
        onPressed: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: AppColors.sage,
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 140.0,
              collapsedHeight: 70.0,
              elevation: 10,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: true,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text('Tạo đơn hàng',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: FontSize.soBig,
                                  color: Colors.white)),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Lottie.asset(JsonAnimates.add, height: 20)),
                      ]))),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return OptionItem(
              icon: _options[index].icon,
              title: _options[index].title,
              onPressed: () {},
            );
          }, childCount: _options.length)),
        ],
      ),
    );
  }
}
