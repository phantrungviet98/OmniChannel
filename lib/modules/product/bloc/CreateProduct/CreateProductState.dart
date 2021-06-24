import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';

class CreateProductState extends Equatable {
  const CreateProductState(
      {@required this.createProductInput,
        @required this.status,
        this.productDetail,
      });

  final CreateOneProductInput createProductInput;
  final Status status;
  final ProductDetail productDetail;

  @override
  List<Object> get props => [createProductInput, status, productDetail];
}

extension CreateProductStateCopyWith on CreateProductState {
  CreateProductState copyWith({
    CreateOneProductInput createProductInput,
    Status status,
    ProductDetail productDetail,
  }) {
    return CreateProductState(
      createProductInput: createProductInput ?? this.createProductInput,
      status: status ?? this.status,
      productDetail: productDetail ?? this.productDetail,
    );
  }
}

class ProductDetail extends Equatable {
  ProductDetail({this.status});
  final Status status;
  @override
  List<Object> get props => [status];
}
