import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
part 'CreateProductState.g.dart';

enum Status {
  initial, loading, success, fail
}

@CopyWith()
class CreateProductState extends Equatable {
  const CreateProductState({@required this.createProductInput, @required this.status});
  final CreateOneProductInput createProductInput;
  final Status status;

  @override
  List<Object> get props => [createProductInput, status];
}
