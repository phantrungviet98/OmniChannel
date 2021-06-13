import 'package:flutter/cupertino.dart';

abstract class LocationDataEvent {
  const LocationDataEvent();
}

class LocationDataEventGetCities extends LocationDataEvent {
  const LocationDataEventGetCities({this.hasFetchDistrictsWardsAlso});

  final bool hasFetchDistrictsWardsAlso;
}

class LocationDataEventGetDistricts extends LocationDataEvent {
  const LocationDataEventGetDistricts({@required this.cityCode});

  final int cityCode;
}

class LocationDataEventGetWards extends LocationDataEvent {
  const LocationDataEventGetWards({@required this.districtCode});

  final int districtCode;
}

class LocationDataEventGetCitiesDistrictsWards extends LocationDataEvent {
  const LocationDataEventGetCitiesDistrictsWards(
      {@required this.cityCode, @required this.districtCode});

  final int cityCode;
  final int districtCode;
}
