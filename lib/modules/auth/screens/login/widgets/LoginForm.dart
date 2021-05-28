import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginBloc.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginEvent.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginState.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(hintText: 'Email / Số điện thoại'),
          controller: _usernameController..text = 'tdtu247',
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Mật khẩu'),
          controller: _passwordController..text = 'tdtu123456',
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,

        ),
        Container(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return AppButton(
                  loading: state is LoginStateLoading,
                  title: 'Đăng nhập',
                  onPressed: () {
                    // Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
                    // return;
                    BlocProvider.of<LoginBloc>(context).add(LoginEventSubmitted(
                        username: _usernameController.text,
                        password: _passwordController.text));
                  });
            },
          ),
          margin: EdgeInsets.only(top: 20),
        ),
      ],
    );
  }
}
