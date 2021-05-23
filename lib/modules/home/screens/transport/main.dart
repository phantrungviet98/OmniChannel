import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';

class TransportScreen extends BaseScreen {
  static final theme = ScreenTheme(
      color: AppColors.paleSilver,
      title: 'Vận chuyển',
      icon: Icons.local_shipping);

  @override
  Widget build(BuildContext context) {
    return Text(theme.title);
  }
}
