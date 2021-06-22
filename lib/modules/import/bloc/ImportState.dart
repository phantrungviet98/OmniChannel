import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';

class ImportState extends Equatable {
  const ImportState({this.status, this.imports});
  final Status status;
  final ExportsPaging imports;

  ImportState copyWith({
    Status status,
    ExportsPaging import,
  }) =>
      ImportState(
        status: status ?? this.status,
        imports: import ?? this.imports,
      );


  @override
  List<Object> get props => [status, imports];
}