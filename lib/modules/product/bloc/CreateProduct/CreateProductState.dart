import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';

class CreateProductState extends Equatable {
  const CreateProductState({@required this.createProductInput, @required this.status});
  final CreateOneProductInput createProductInput;
  final Status status;

  @override
  List<Object> get props => [createProductInput, status];
}

extension CreateProductStateCopyWith on CreateProductState {
  CreateProductState copyWith({
    CreateOneProductInput createProductInput,
    Status status,
  }) {
    return CreateProductState(
      createProductInput: createProductInput ?? this.createProductInput,
      status: status ?? this.status,
    );
  }
}