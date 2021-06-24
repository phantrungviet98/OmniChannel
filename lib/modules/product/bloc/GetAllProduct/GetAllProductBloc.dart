import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductState.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {
  GetAllProductBloc() : super(GetAllProductStateLoading());

  @override
  Stream<GetAllProductState> mapEventToState(GetAllProductEvent event) async* {
    yield GetAllProductStateLoading();
    final result = await RemoteRepository.getAllProducts();
    if (result.isRight) {
      final products = result.fold((_) => null, (data) => data);
      yield GetAllProductStateSuccess(products: products);
    } else {
      yield GetAllProductStateFail();
    }
  }
}