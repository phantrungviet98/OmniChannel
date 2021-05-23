import 'package:omnichannel_flutter/data/modals/LoginResponse.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';

abstract class AccountEvent {
  const AccountEvent();
}

class AccountEventStatusChanged extends AccountEvent {
  const AccountEventStatusChanged({this.status, this.accessToken, this.user});
  final AuthenticationStatus status;
  final UserData user;
  final String accessToken;
}

class AccountEventLogoutRequest extends AccountEvent {
}