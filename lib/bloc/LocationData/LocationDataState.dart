import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Location.dart';

class LocationStatus<T> extends Equatable {
  const LocationStatus({@required this.status, @required this.data});
  final Status status;
  final List<T> data;

  @override
  List<Object> get props => [status, data];
}

extension LocationStatusCopyWith<T> on LocationStatus<T> {
  LocationStatus<T> copyWith({
    List<T> data,
    Status status,
  }) {
    return LocationStatus<T>(
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}


class LocationDataState extends Equatable {
  const LocationDataState({this.city, this.district, this.ward});
  final LocationStatus<City> city;
  final LocationStatus<District> district;
  final LocationStatus<Ward> ward;
  @override
  List<Object> get props => [city, district, ward];
}

extension LocationDataStateCopyWith on LocationDataState {
  LocationDataState copyWith({
    LocationStatus<City> city,
    LocationStatus<District> district,
    LocationStatus<Ward> ward,
  }) {
    return LocationDataState(
      city: city ?? this.city,
      district: district ?? this.district,
      ward: ward ?? this.ward,
    );
  }
}
