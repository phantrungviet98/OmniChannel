import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Stock.dart';

class StorehouseState extends Equatable {
  const StorehouseState({this.stocks, this.status});
  final List<Stock> stocks;
  final Status status;

  @override
  List<Object> get props => [stocks, status];
}

extension StorehouseStateCopyWith on StorehouseState {
  StorehouseState copyWith({
    Status status,
    List<Stock> stocks,
  }) {
    return StorehouseState(
      status: status ?? this.status,
      stocks: stocks ?? this.stocks,
    );
  }
}