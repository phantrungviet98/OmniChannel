import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Order.dart';

class OrderState extends Equatable {
  const OrderState({this.ordersPaging});

  final StateOrdersPaging ordersPaging;

  OrderState copyWith({StateOrdersPaging ordersPaging}) =>
      OrderState(ordersPaging: ordersPaging ?? this.ordersPaging);

  @override
  List<Object> get props => [ordersPaging];
}

class StateOrdersPaging extends Equatable {
  const StateOrdersPaging({this.status, this.data});

  final Status status;
  final OrdersPaging data;

  @override
  List<Object> get props => [status, data];

  StateOrdersPaging copyWith({Status status, OrdersPaging data}) =>
      StateOrdersPaging(status: status ?? this.status, data: data ?? this.data);
}
