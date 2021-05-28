abstract class CreateCateState {
  const CreateCateState();
}

class CreateCateStateInitial extends CreateCateState {
  const CreateCateStateInitial();
}

class CreateCateStateLoading extends CreateCateState {
  const CreateCateStateLoading();
}

class CreateCateStateFail extends CreateCateState {
  const CreateCateStateFail();
}

class CreateCateStateSuccess extends CreateCateState {
  const CreateCateStateSuccess();
}