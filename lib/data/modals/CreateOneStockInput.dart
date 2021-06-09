class CreateOneStockInput {
  String name;
  String phoneNumber;
  String address;
  int cityCode;
  int districtCode;
  int wardCode;

  CreateOneStockInput(
      {this.name,
        this.phoneNumber,
        this.address,
        this.cityCode,
        this.districtCode,
        this.wardCode});

  CreateOneStockInput.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    cityCode = json['city_code'];
    districtCode = json['district_code'];
    wardCode = json['ward_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['city_code'] = this.cityCode;
    data['district_code'] = this.districtCode;
    data['ward_code'] = this.wardCode;
    return data;
  }
}

extension CreateOneStockInputCopyWith on CreateOneStockInput {
  CreateOneStockInput copyWith({
    String address,
    int cityCode,
    int districtCode,
    String name,
    String phoneNumber,
    int wardCode,
  }) {
    return CreateOneStockInput(
      address: address ?? this.address,
      cityCode: cityCode ?? this.cityCode,
      districtCode: districtCode ?? this.districtCode,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      wardCode: wardCode ?? this.wardCode,
    );
  }
}
