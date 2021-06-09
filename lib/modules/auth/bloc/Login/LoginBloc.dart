import 'package:bloc/bloc.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Account/AccountBloc.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Account/AccountEvent.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginEvent.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginState.dart';
import 'package:omnichannel_flutter/config/client.dart';
import 'package:omnichannel_flutter/data/modals/LoginResponse.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/utis/Failure.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.accountBloc}) : super(LoginStateInitial());
  final AccountBloc accountBloc;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEventSubmitted) {
      if (event.username == '' || event.username == '') {
        yield LoginStateFail();
      } else {
        yield LoginStateLoading();
        Either<Failure, LoginResponse> res = await RemoteRepository.login(
            event.username, event.password);
        if (res.isLeft) {
          yield LoginStateFail();
        } else {
          final data = res.fold((_) => null, (data) => data);
          if (data.error != null) {
            yield LoginStateFail();
          } else {
            accountBloc.add(AccountEventStatusChanged(
                status: AuthenticationStatus.authenticated,
                accessToken: data.accessToken,
                user: data.userData));
            PosServiceConfigs.token = data.accessToken;
            ShippingServiceConfigs.token = data.accessToken;
            yield LoginStateSuccess();
          }
        }
      }
    }
  }
}