abstract class LoginState {
  const LoginState();
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();
}

class LoginStateFail extends LoginState {
  const LoginStateFail();
}

class LoginStateSuccess extends LoginState {
  const LoginStateSuccess();
}