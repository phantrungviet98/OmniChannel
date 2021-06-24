import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryState.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState(allCate: AllCate(data: [], status: Status.initial))) {
    add(CategoryEventGetAll());
  }

  List<Cats> cats = [];

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryEventGetAll) {
      yield state.copyWith(allCate: state.allCate.copyWith(status: Status.loading));
      try {
        final response = await RemoteRepository.getCategories();
        if (response.isLeft) {
          yield state.copyWith(allCate: state.allCate.copyWith(status: Status.fail));
        } else {
          final data = response.fold((_) => null, (data) => data);
          cats = data.cats;
          yield state.copyWith(allCate: AllCate(data: List.from(cats), status: Status.success));
        }
      } catch (e) {

      }
    }
    if (event is CategoryEventSearch) {
      if (event.searchText.isEmpty) {
        yield state.copyWith(allCate: state.allCate.copyWith(data: cats));
      }
      final searchedCate = cats.where((element) =>
          element.name.toLowerCase().contains(event.searchText.toLowerCase())).toList();
      yield state.copyWith(allCate: state.allCate.copyWith(data: searchedCate));
    }
  }
}
