import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockImportExportInput.dart';
import 'package:omnichannel_flutter/data/modals/LookupProduct.dart';

class CreateImportExportState extends Equatable {
  const CreateImportExportState({this.lookup, this.payload, this.isCreating = false});

  final LookupProducts lookup;
  final CreateOneStockImportExportInput payload;
  final bool isCreating;

  CreateImportExportState copyWith(
          {LookupProducts lookup,
          CreateOneStockImportExportInput payload,
          bool isCreating}) =>
      CreateImportExportState(
          lookup: lookup ?? this.lookup,
          payload: payload ?? this.payload,
          isCreating: isCreating ?? this.isCreating);

  @override
  List<Object> get props => [lookup, payload, isCreating];
}

class LookupProducts extends Equatable {
  const LookupProducts({this.data, this.status});

  final List<LookupProductModal> data;
  final Status status;

  LookupProducts copyWith({List<LookupProductModal> data, Status status}) =>
      LookupProducts(data: data ?? this.data, status: status ?? this.status);

  @override
  List<Object> get props => [data, status];
}
