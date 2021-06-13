import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseEvent.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseState.dart';

class StorehouseBloc extends Bloc<StorehouseEvent, StorehouseState> {
  StorehouseBloc() : super(StorehouseState(status: Status.initial, stocks: []));

  @override
  Stream<StorehouseState> mapEventToState(StorehouseEvent event) async* {
    if (event is StoreHouseEventGetStocks) {
      yield state.copyWith(status: Status.loading);
      try {
        final result = await RemoteRepository.getStocks();
        yield state.copyWith(status: Status.success, stocks: result);
      } catch (e) {
        yield state.copyWith(status: Status.fail);
      }
    }
  }
}
