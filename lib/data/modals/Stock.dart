import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/data/modals/Location.dart';

class Stocks {
  List<Stock> stocks = [];

  Stocks({this.stocks});

  Stocks.fromJson(Map<String, dynamic> json) {
    if (json['stocks'] != null) {
      json['stocks'].forEach((v) {
        stocks.add(new Stock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stocks != null) {
      data['stocks'] = this.stocks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stock extends Equatable {
  String id;
  String name;
  String phoneNumber;
  String address;
  int wardCode;
  int districtCode;
  int cityCode;
  bool isPrimary;
  bool isActive;
  String createdBy;
  int dateCreated;
  int dateUpdated;
  String updatedBy;
  City city;
  District district;
  Ward ward;

  Stock(
      {
      this.id,
      this.name,
      this.phoneNumber,
      this.address,
      this.wardCode,
      this.districtCode,
      this.cityCode,
      this.isPrimary,
      this.isActive,
      this.createdBy,
      this.dateCreated,
      this.dateUpdated,
      this.updatedBy,
      this.city,
      this.district,
      this.ward});

  Stock.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    wardCode = json['ward_code'];
    districtCode = json['district_code'];
    cityCode = json['city_code'];
    isPrimary = json['is_primary'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    dateCreated = json['date_created'];
    dateUpdated = json['date_updated'];
    updatedBy = json['updated_by'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
    ward = json['ward'] != null ? new Ward.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['ward_code'] = this.wardCode;
    data['district_code'] = this.districtCode;
    data['city_code'] = this.cityCode;
    data['is_primary'] = this.isPrimary;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['date_created'] = this.dateCreated;
    data['date_updated'] = this.dateUpdated;
    data['updated_by'] = this.updatedBy;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district.toJson();
    }
    if (this.ward != null) {
      data['ward'] = this.ward.toJson();
    }
    return data;
  }

  //String name;
  //   String phoneNumber;
  //   String address;
  //   int wardCode;
  //   int districtCode;
  //   int cityCode;
  //   bool isPrimary;
  //   bool isActive;
  //   String createdBy;
  //   int dateCreated;
  //   double dateUpdated;
  //   String updatedBy;
  //   City city;
  //   District district;
  //   Ward ward;

  @override
  List<Object> get props => [
        name,
        phoneNumber,
        address,
        wardCode,
        districtCode,
        cityCode,
        isPrimary,
        isActive,
        createdBy,
        dateCreated,
        dateUpdated,
        updatedBy,
        city,
        district,
        ward,
      ];
}
