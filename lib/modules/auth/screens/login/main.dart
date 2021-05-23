import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginBloc.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginState.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modules/auth/screens/login/widgets/LoginForm.dart';
import 'package:omnichannel_flutter/utis/ui/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class LoginScreen extends BaseScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Đăng nhập',
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginStateSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
            showSnackBar(context, text: 'Đăng nhập thành công');
          } else if (state is LoginStateFail) {
            showSnackBar(context,
                text:
                    'Đăng nhập không thành công. Vui lòng kiểm tra thông tin đăng nhập, hoặc liên hệ admin nhé');
          }
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}
