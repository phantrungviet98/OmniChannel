import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';

class ExportState extends Equatable {
  const ExportState({this.status, this.exports});
  final Status status;
  final ExportsPaging exports;

  ExportState copyWith({
    Status status,
    ExportsPaging exports,
  }) =>
      ExportState(
        status: status ?? this.status,
        exports: exports ?? this.exports,
      );


  @override
  List<Object> get props => [status, exports];
}