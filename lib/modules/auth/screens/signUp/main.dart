import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class SignUpScreen extends BaseScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Đăng ký',
      ),
      body: Center(
        child: Text(
          'Hiện tại ứng dụng chưa hỗ trợ tính năng đăng ký. \n Bạn vui lòng liên hệ admin nhé!',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
