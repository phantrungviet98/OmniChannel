import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:omnichannel_flutter/assets/png-jpg/PngJpg.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/constant/Metrics.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:provider/provider.dart';

final List<OnBoardModel> _onBoardData = [
  const OnBoardModel(
    title: "Ứng dụng quản lý bán hàng miễn phí",
    description: "Dành riêng bạn các cửa hàng bán lẻ",
    imgUrl: PngJpg.onBoardFree,
  ),
  const OnBoardModel(
    title: "Tạo đơn hàng nhanh chỉ với 6s",
    description: "Giúp bán hàng nhanh chóng và thuận tiện hơn",
    imgUrl: PngJpg.onBoardCreate,
  ),
  const OnBoardModel(
    title: "Hỗ trợ bán hàng đa kênh",
    description: "Hỗ trợ bán hàng đa kênh 1 cách thuận tiện nhất",
    imgUrl: PngJpg.onBoardOmni,
  ),
];

class OnBoardScreen extends BaseScreen {
  final PageController _pageController = PageController();

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      // Navigator.pushNamedAndRemoveUntil('', newRouteName, (route) => false)
    }
  }

  void _onPressLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sage,
      body: Provider(
        create: (_) => OnBoardState(),
        child: OnBoard(
          pageController: _pageController,
          onBoardData: _onBoardData,
          pageIndicatorStyle: PageIndicatorStyle(
              activeColor: AppColors.dimGray,
              activeSize: Size(6.0, 6.0),
              inactiveSize: Size(4.0, 4.0),
              inactiveColor: Colors.blueGrey,
              width: 100),
          skipButton: Container(
            margin: EdgeInsets.only(right: 16),
            child: Consumer<OnBoardState>(
              builder: (context, value, child) {
                if (!value.isLastPage) {
                  return AppButton(
                    title: 'Bỏ qua',
                    onPressed: () {
                      _pageController.animateToPage(_onBoardData.length - 1,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOutSine);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          imageHeight: Metrics.getScreenHeight(context) * 0.5,
          imageWidth: Metrics.getScreenWidth(context) * 0.8,
          nextButton: Consumer<OnBoardState>(
            builder: (context, state, child) {
              if (!state.isLastPage) {
                return AppButton(
                    title: 'Tiếp theo', onPressed: () => _onNextTap(state));
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    onPressed: () => Navigator.pushNamed(context, '/sign-up'),
                    title: 'Đăng ký ngay',
                  ),
                  AppButton(
                    title: 'Đăng nhập',
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
