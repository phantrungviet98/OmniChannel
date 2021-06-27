import 'package:omnichannel_flutter/constant/OrderStatus.dart';

getOrderStatusFromRawValue(int value) {
  switch(value) {
    case 1:
      return OrderStatus.NEW;
    case 2:
      return OrderStatus.CONFIRMED;
    case 3:
      return OrderStatus.SENT;
    case 4:
      return OrderStatus.RECEIVED;
    case 5:
      return OrderStatus.RETURNING;
    default: return OrderStatus.UNKNOWN;
  }
}