abstract class ProductState {
  const ProductState();
}

class CreateCateStateInitial extends ProductState {
  const CreateCateStateInitial();
}

class CreateCateStateLoading extends ProductState {
  const CreateCateStateLoading();
}

class CreateCateStateFail extends ProductState {
  const CreateCateStateFail();
}

class CreateCateStateSuccess extends ProductState {
  const CreateCateStateSuccess();
}

