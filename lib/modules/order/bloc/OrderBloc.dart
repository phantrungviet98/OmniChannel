import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Order.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/order/bloc/OrderEvent.dart';
import 'package:omnichannel_flutter/modules/order/bloc/OrderState.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc()
      : super(OrderState(
            ordersPaging: StateOrdersPaging(
                status: Status.initial,
                data: OrdersPaging(count: 0, items: [])))) {
    add(OrdersPagingEvent(type: OrdersPagingType.refresh));
  }

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is OrdersPagingEvent) {
      yield state.copyWith(
          ordersPaging: state.ordersPaging.copyWith(status: Status.initial));
      try {
        final result =
            await RemoteRepository.getOrdersPaging(1, 10);
        yield state.copyWith(
            ordersPaging:
                StateOrdersPaging(status: Status.success, data: result));
      } catch (e) {
        yield state.copyWith(
            ordersPaging: state.ordersPaging.copyWith(status: Status.fail));
      }
    }
  }
}
