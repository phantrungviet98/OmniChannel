import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';

abstract class CreateStockEvent {
  const CreateStockEvent();
}

class CreateStockEventDataChanged extends CreateStockEvent {
  const CreateStockEventDataChanged(this.data);
  final CreateOneStockInput data;
}

class CreateStockEventRequest extends CreateStockEvent {
  const CreateStockEventRequest();
}
