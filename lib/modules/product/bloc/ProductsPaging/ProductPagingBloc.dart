import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/product/bloc/ProductsPaging/ProductPagingEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/ProductsPaging/ProductPagingState.dart';

const PER_PAGE = 10;

class ProductPagingBloc extends Bloc<ProductPagingEvent, ProductPagingState> {
  ProductPagingBloc()
      : super(ProductPagingState(
            status: Status.initial,
            pageInfo: PageInfo(currentPage: 1, hasNextPage: false),
            perPage: PER_PAGE,
            products: [])) {
    this.add(ProductPagingEvent(ProductPagingType.REFRESH));
  }

  @override
  Stream<ProductPagingState> mapEventToState(ProductPagingEvent event) async* {
    yield state.copyWith(status: Status.loading);
    try {
      final page = _getPage(event);
      if (page == null) {
        return;
      } else {
        final result = await RemoteRepository.getProductsPaging(
            page, PER_PAGE, FilterFindManyProductInput());
        List<Product> items = List.from(state.products);
        if (event.type == ProductPagingType.LOAD_MORE) {
          items.addAll(result.items);
        } else {
          items = result.items;
        }

        yield state.copyWith(
            status: Status.success,
            perPage: PER_PAGE,
            products: items,
            pageInfo: PageInfo(
                currentPage: page,
                pageCount: result.pageInfo.pageCount,
                hasNextPage: result.pageInfo.hasNextPage));
      }
    } catch (e) {
      log(e.toString());
      yield state.copyWith(status: Status.fail);
    }
  }

  _getPage(ProductPagingEvent event) {
    if (event.type == ProductPagingType.REFRESH) {
      return 1;
    }
    if (state.pageInfo.hasNextPage) {
      return state.pageInfo.currentPage + 1;
    } else {
      return null;
    }
  }
}
