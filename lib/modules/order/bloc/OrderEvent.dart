enum OrdersPagingType { refresh, load_more }

abstract class OrderEvent {
  const OrderEvent();
}

class OrdersPagingEvent extends OrderEvent {
  const OrdersPagingEvent({this.type});
  final OrdersPagingType type;
}