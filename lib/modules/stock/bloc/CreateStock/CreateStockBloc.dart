import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataBloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataEvent.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockEvent.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockState.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockState.model.dart';

class CreateStockBloc extends Bloc<CreateStockEvent, CreateStockState> {
  CreateStockBloc(this.locationDataBloc)
      : super(CreateStockState(
            createOneStockInput: CreateOneStockInput(),
            status: Status.initial,
            error: CreateStockErrorModel()));
  final LocationDataBloc locationDataBloc;

  @override
  Stream<CreateStockState> mapEventToState(CreateStockEvent event) async* {
    if (event is Reset) {
      yield CreateStockState(
          createOneStockInput: CreateOneStockInput(),
          status: Status.initial,
          error: CreateStockErrorModel());
    }

    if (event is UpdateStockEventInitData) {
      locationDataBloc.add(LocationDataEventGetCitiesDistrictsWards(
          cityCode: event.data.cityCode, districtCode: event.data.districtCode));
      yield state.copyWith(createOneStockInput: event.data);
    }

    if (event is CreateStockEventDataChanged) {
      final data = event.data;

      CreateStockState tState = state.copyWith(
          createOneStockInput: state.createOneStockInput.copyWith(
            address: data.address,
            name: data.name,
            phoneNumber: data.phoneNumber,
            cityCode: data.cityCode,
            districtCode: data.districtCode,
            wardCode: data.wardCode,
          ),
          error: CreateStockErrorModel());

      // Update case
      if (data.cityCode != null &&
          data.cityCode != state.createOneStockInput.cityCode) {
        tState.createOneStockInput.districtCode = null;
        tState.createOneStockInput.wardCode = null;
        locationDataBloc
            .add(LocationDataEventGetDistricts(cityCode: data.cityCode));
      } else if (data.districtCode != null &&
          data.districtCode != state.createOneStockInput.districtCode) {
        tState.createOneStockInput.wardCode = null;
        locationDataBloc
            .add(LocationDataEventGetWards(districtCode: data.districtCode));
      }
      yield tState;
    }
    if (event is CreateStockEventRequest) {
      final error = _validData();
      if (error.checkIfAnyError()) {
        yield state.copyWith(error: error);
      } else {
        yield state.copyWith(status: Status.loading);
        try {
          final result =
              await RemoteRepository.createStock(state.createOneStockInput);
          if (result != null) {
            yield state.copyWith(status: Status.success);
          }
        } catch (e) {
          yield state.copyWith(status: Status.fail);
        }
      }
    }

    if (event is UpdateStockEventRequest) {
      final error = _validData();
      if (error.checkIfAnyError()) {
        yield state.copyWith(error: error);
      } else {
        yield state.copyWith(status: Status.loading);
        try {
          final result = await RemoteRepository.updateStock(event.id, state.createOneStockInput);
          log('Update Stock' + result.toString());
          if (result != null) {
            yield state.copyWith(status: Status.success);
          }
        } catch (e) {
          yield state.copyWith(status: Status.fail);
        }
      }
    }
  }

  CreateStockErrorModel _validData() {
    final error = CreateStockErrorModel();
    final data = state.createOneStockInput;
    error.nameError = (data.name == null || data.name.isEmpty)
        ? 'Vui lòng nhập tên kho'
        : null;
    error.phoneNumberError =
        (data.phoneNumber == null || data.phoneNumber.isEmpty)
            ? 'Vui lòng nhập số điện thoại'
            : null;
    error.addressError = (data.address == null || data.address.isEmpty)
        ? 'Vui lòng nhập địa chỉ'
        : null;
    error.cityError =
        (data.cityCode == null) ? 'Vui lòng chọn thành phố' : null;
    error.districtError =
        (data.districtCode == null) ? 'Vui lòng chọn quận/huyện' : null;
    error.wardError =
        (data.wardCode == null) ? 'Vui lòng chọn phường xã' : null;
    return error;
  }
}
