import 'package:flutter/material.dart';

class LoginEvent {
  const LoginEvent();
}

class LoginEventSubmitted extends LoginEvent {
  final String username;
  final String password;

  const LoginEventSubmitted({@required this.username, @required this.password});
}