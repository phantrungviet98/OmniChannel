abstract class CreateProductState {
  const CreateProductState();
}

class CreateProductStateInitial extends CreateProductState {
  const CreateProductStateInitial();
}

class CreateProductStateLoading extends CreateProductState {
  const CreateProductStateLoading();
}

class CreateProductStateSuccess extends CreateProductState {
  const CreateProductStateSuccess();
}

class CreateProductStateFail extends CreateProductState {
  const CreateProductStateFail();
}