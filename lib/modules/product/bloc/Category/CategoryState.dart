import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryStateInitial extends CategoryState {
  const CategoryStateInitial();

  @override
  List<Object> get props => [];
}

class CategoryStateGetAllLoading extends CategoryState {
  const CategoryStateGetAllLoading();

  @override
  List<Object> get props => [];
}

class CategoryStateGetAllFail extends CategoryState {
  const CategoryStateGetAllFail();

  @override
  List<Object> get props => [];
}

class CategoryStateGetAllSuccess extends CategoryState {
  const CategoryStateGetAllSuccess({this.allCate});
  final List<Cats> allCate;

  @override
  List<Object> get props => [allCate];
}