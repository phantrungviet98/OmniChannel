import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int id;
  final String label;

  const Location(this.id, this.label);

  @override
  List<Object> get props => [id, label];
}

class City extends Location {
  const City({id, label}): super(id, label);

  factory City.fromJson(Map<String, dynamic> json) =>
      City(id: json['_id'], label: json['label']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}

class District extends Location {
  const District({id, label}): super(id, label);

  factory District.fromJson(Map<String, dynamic> json) =>
      District(id: json['_id'], label: json['label']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}

class Ward extends Location {
  const Ward({id, label}): super(id, label);

  Ward copyWith({
    int id,
    String label,
  }) =>
      Ward(
        id: id ?? this.id,
        label: label ?? this.label,
      );

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        id: json["_id"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "label": label,
      };

  @override
  List<Object> get props => [id, label];
}

class FilterFindManyDistrictInput {
  FilterFindManyDistrictInput({
    this.cityCode,
  });

  final int cityCode;

  FilterFindManyDistrictInput copyWith({
    int cityCode,
  }) =>
      FilterFindManyDistrictInput(
        cityCode: cityCode ?? this.cityCode,
      );

  factory FilterFindManyDistrictInput.fromJson(Map<String, dynamic> json) =>
      FilterFindManyDistrictInput(
        cityCode: json["city_code"],
      );

  Map<String, dynamic> toJson() => {
        "city_code": cityCode,
      };
}

class FilterFindManyWardInput {
  FilterFindManyWardInput({
    this.districtCode,
  });

  final int districtCode;

  FilterFindManyWardInput copyWith({
    int districtCode,
  }) =>
      FilterFindManyWardInput(
        districtCode: districtCode ?? this.districtCode,
      );

  factory FilterFindManyWardInput.fromJson(Map<String, dynamic> json) => FilterFindManyWardInput(
    districtCode: json["district_code"],
  );

  Map<String, dynamic> toJson() => {
    "district_code": districtCode,
  };
}
