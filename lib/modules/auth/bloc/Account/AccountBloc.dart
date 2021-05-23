import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Account/AccountEvent.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Account/AccountState.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountState.unknown());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is AccountEventStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AccountEventLogoutRequest) {
      yield AccountState.unauthenticated();
    }
  }

  Future<AccountState> _mapAuthenticationStatusChangedToState(
    AccountEventStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AccountState.unauthenticated();
      case AuthenticationStatus.authenticated:
        return event.user != null
            ? AccountState.authenticated(event.user, event.accessToken)
            : const AccountState.unauthenticated();
      default:
        return const AccountState.unknown();
    }
  }
}
