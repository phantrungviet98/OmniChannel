import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';

abstract class GetAllProductState {
  const GetAllProductState();
}

class GetAllProductStateInitial extends GetAllProductState {
  const GetAllProductStateInitial();
}

class GetAllProductStateLoading extends GetAllProductState {
  const GetAllProductStateLoading();
}

class GetAllProductStateFail extends GetAllProductState {
  const GetAllProductStateFail();
}

class GetAllProductStateSuccess extends GetAllProductState {
  const GetAllProductStateSuccess({this.products});
  final List<Product> products;
}