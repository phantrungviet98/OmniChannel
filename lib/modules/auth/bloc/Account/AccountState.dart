import 'package:omnichannel_flutter/data/modals/LoginResponse.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';

class AccountState {
  final AuthenticationStatus status;
  final UserData user;
  final String accessToken;

  const AccountState._({
    this.status = AuthenticationStatus.unknown,
    this.user = UserData.empty,
    this.accessToken = '',
  });

  const AccountState.unknown() : this._();

  const AccountState.authenticated(UserData user, String accessToken)
      : this._(
            status: AuthenticationStatus.authenticated,
            user: user,
            accessToken: accessToken);

  const AccountState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
}
