import 'package:flutter/cupertino.dart';

abstract class LocationDataEvent {
  const LocationDataEvent();
}

class LocationDataEventGetCities extends LocationDataEvent {
  const LocationDataEventGetCities();
}

class LocationDataEventGetDistricts extends LocationDataEvent {
  const LocationDataEventGetDistricts({@required this.cityCode});
  final int cityCode;
}

class LocationDataEventGetWards extends LocationDataEvent {
  const LocationDataEventGetWards({this.districtCode});
  final int districtCode;
}