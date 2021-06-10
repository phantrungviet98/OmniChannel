import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataBloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataEvent.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';
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
    if (event is CreateStockEventDataChanged) {
      final data = event.data;
      if (data.cityCode != null &&
          data.cityCode != state.createOneStockInput.cityCode) {
        locationDataBloc
            .add(LocationDataEventGetDistricts(cityCode: data.cityCode));
        data.districtCode = null;
        data.wardCode = null;
      } else if (data.districtCode != null &&
          data.districtCode != state.createOneStockInput.districtCode) {
        locationDataBloc.add(LocationDataEventGetWards(districtCode: data.districtCode));
        data.wardCode = null;
      }
      yield state.copyWith(
          createOneStockInput: state.createOneStockInput.copyWith(
            address: data.address,
            name: data.name,
            phoneNumber: data.phoneNumber,
            cityCode: data.cityCode,
            districtCode: data.districtCode,
            wardCode: data.wardCode,
          ),
          error: CreateStockErrorModel());
    }
    if (event is CreateStockEventRequest) {
      final error = _validData();
      if (error.checkIfAnyError()) {
        yield state.copyWith(error: error);
      } else {}
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
