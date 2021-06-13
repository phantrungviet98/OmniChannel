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
      yield* _mapCitiesToState(state);
    }

    if (event is LocationDataEventGetDistricts) {
      yield* _mapDistrictsToState(state, event.cityCode);
    }

    if (event is LocationDataEventGetWards) {
      yield* _mapWardsToState(state, event.districtCode);
    }

    if (event is LocationDataEventGetCitiesDistrictsWards) {
      yield* _mapCitiesDistrictsWardsToState(state, event);
    }
  }

  Stream<LocationDataState> _mapCitiesToState(LocationDataState state) async* {
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

  Stream<LocationDataState> _mapDistrictsToState(LocationDataState state,
      int cityCode) async* {
    yield state.copyWith(
        district: state.district.copyWith(status: Status.loading, data: []),
        ward: LocationStatus(status: Status.initial, data: []));
    try {
      final result = await RemoteRepository.getDistricts(cityCode);
      yield state.copyWith(
          district:
          state.district.copyWith(data: result, status: Status.success));
    } catch (e) {
      yield state.copyWith(
          district: state.district.copyWith(status: Status.fail));
    }
  }

  Stream<LocationDataState> _mapWardsToState(LocationDataState state,
      int districtCode) async* {
    yield state.copyWith(ward: state.ward.copyWith(status: Status.loading, data: []));
    try {
      final result = await RemoteRepository.getWards(districtCode);
      yield state.copyWith(
          ward: state.ward.copyWith(data: result, status: Status.success));
    } catch (e) {
      yield state.copyWith(ward: state.ward.copyWith(status: Status.fail));
    }
  }

  Stream<LocationDataState> _mapCitiesDistrictsWardsToState(
      LocationDataState state, LocationDataEventGetCitiesDistrictsWards event) async* {
    yield state.copyWith(
        city: state.city.copyWith(status: Status.loading, data: []),
        district: state.district.copyWith(status: Status.loading, data: []),
        ward: state.ward.copyWith(status: Status.loading, data: []));
    try {
      final result = await Future.wait([
        RemoteRepository.getCities(),
        RemoteRepository.getDistricts(event.cityCode),
        RemoteRepository.getWards(event.districtCode)
      ]);
      yield state.copyWith(
        city: state.city.copyWith(data: result[0], status: Status.success),
        district: state.district.copyWith(data: result[1], status: Status.success),
        ward: state.ward.copyWith(data: result[2], status: Status.success)
      );
    } catch (e) {
      yield state.copyWith(
          city: state.city.copyWith(status: Status.fail),
          district: state.district.copyWith(status: Status.fail),
          ward: state.ward.copyWith(status: Status.fail));
    }
  }
}
