import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/constant/Metrics.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';
import 'package:omnichannel_flutter/modules/home/screens/order/widgets/OptionItem.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class ProductScreen extends BaseScreen {
  static final theme = ScreenTheme(
      color: AppColors.sage, title: 'Sản phẩm', icon: Icons.inventory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  Container(
                    width: Metrics.getScreenWidth(context) * 0.8,
                    height: 140,
                    margin: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      child: Column(
                        children: [Icon(Icons.add), Text('Thêm sản phẩm')],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/create-product');
                      },
                    ),
                  ),
                  OptionItem(
                    icon: Icon(Icons.list_alt),
                    title: 'Quản lý sản phẩm',
                    onPressed: () => Navigator.pushNamed(context, '/product-management'),
                  )
                ],
              );
            }, childCount: 1))
          ],
        ),
      ),
    );
  }
}
