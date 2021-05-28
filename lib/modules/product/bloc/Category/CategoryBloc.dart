import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryState.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryStateInitial());
  List<Cats> cats = [];

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    log(event.toString());
    if (event is CategoryEventGetAll) {
      yield CategoryStateGetAllLoading();
      final response = await RemoteRepository.getCategories();
      if (response.isLeft) {
        yield CategoryStateGetAllFail();
      } else {
        final data = response.fold((_) => null, (data) => data);
        cats.addAll(data.cats);
        yield CategoryStateGetAllSuccess(allCate: cats);
      }
    }
    if (event is CategoryEventSearch) {
      if (event.searchText.isEmpty) {
        yield CategoryStateGetAllSuccess(allCate: cats);
      }
      final searchedCate = cats.where((element) =>
          element.name.toLowerCase().contains(event.searchText.toLowerCase())).toList();
      yield CategoryStateGetAllSuccess(
          allCate: searchedCate);
    }
  }
}
