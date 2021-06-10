import 'dart:developer';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockState.model.dart';

class CreateStockState extends Equatable {
  const CreateStockState(
      {@required this.createOneStockInput,
      @required this.status,
      this.error});

  final CreateOneStockInput createOneStockInput;
  final Status status;
  final CreateStockErrorModel error;

  @override
  List<Object> get props => [createOneStockInput, status, error];
}

extension CreateStockStateCopyWith on CreateStockState {
  CreateStockState copyWith({
    CreateOneStockInput createOneStockInput,
    Status status,
    CreateStockErrorModel error,
  }) {
    return CreateStockState(
      createOneStockInput: createOneStockInput ?? this.createOneStockInput,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
