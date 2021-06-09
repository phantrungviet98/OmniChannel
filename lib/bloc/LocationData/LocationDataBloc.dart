import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataEvent.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataState.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';

class LocationDataBloc extends Bloc<LocationDataEvent, LocationDataState> {
  LocationDataBloc()
      : super(LocationDataState(
            city: LocationStatus(status: Status.initial, data: []),
            district: LocationStatus(status: Status.initial, data: []),
            ward: LocationStatus(status: Status.initial, data: [])));

  @override
  Stream<LocationDataState> mapEventToState(LocationDataEvent event) async* {
    if (event is LocationDataEventGetCities) {
      yield state.copyWith(
          city: state.city.copyWith(status: Status.loading),
          district: LocationStatus(status: Status.initial, data: []),
          ward: LocationStatus(status: Status.initial, data: []));
      try {
        final result = await RemoteRepository.getCities();
        yield state.copyWith(
            city: state.city.copyWith(data: result, status: Status.success));
      } catch (e) {
        yield state.copyWith(city: state.city.copyWith(status: Status.fail));
      }
    }

    if (event is LocationDataEventGetDistricts) {
      yield state.copyWith(
          district: state.district.copyWith(status: Status.loading),
          ward: LocationStatus(status: Status.initial, data: []));
      try {
        final result = await RemoteRepository.getDistricts(event.cityCode);
        yield state.copyWith(
            district:
                state.district.copyWith(data: result, status: Status.success));
      } catch (e) {
        yield state.copyWith(
            district: state.district.copyWith(status: Status.fail));
      }
    }

    if (event is LocationDataEventGetWards) {
      yield state.copyWith(ward: state.ward.copyWith(status: Status.loading));
      try {
        final result = await RemoteRepository.getWards(event.districtCode);
        log(result.toString());
        yield state.copyWith(
            ward: state.ward.copyWith(data: result, status: Status.success));
      } catch (e) {
        yield state.copyWith(ward: state.ward.copyWith(status: Status.fail));
      }
    }
  }
}
