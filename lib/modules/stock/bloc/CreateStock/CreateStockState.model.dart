import 'package:equatable/equatable.dart';

class CreateStockErrorModel extends Equatable {
  CreateStockErrorModel(
      {this.nameError,
      this.phoneNumberError,
      this.addressError,
      this.cityError,
      this.districtError,
      this.wardError});

  String nameError;
  String phoneNumberError;
  String addressError;
  String cityError;
  String districtError;
  String wardError;

  bool checkIfAnyError() {
    return [
          nameError,
          phoneNumberError,
          addressError,
          cityError,
          districtError,
          wardError
        ].firstWhere((element) => element != null && element.isNotEmpty,
            orElse: null) !=
        null;
  }

  @override
  List<Object> get props => [
        nameError,
        phoneNumberError,
        addressError,
        cityError,
        districtError,
        wardError
      ];
}
