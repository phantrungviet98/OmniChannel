import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';

class CategoryState extends Equatable {
  const CategoryState({this.allCate});
  final AllCate allCate;

  CategoryState copyWith({AllCate allCate}) => CategoryState(allCate: allCate ?? this.allCate);

  @override
  List<Object> get props => [allCate];
}

class AllCate extends Equatable {
  const AllCate({this.status, this.data});
  final Status status;
  final List<Cats> data;
  AllCate copyWith({Status status, List<Cats> data}) =>
      AllCate(
          status: status ?? this.status, data: data ?? this.data);
  @override
  List<Object> get props => [status, data];
}
