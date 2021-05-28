// import 'package:bloc/bloc.dart';
// import 'package:either_option/either_option.dart';
// import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
// import 'package:omnichannel_flutter/modules/product/bloc/Product/ProductEvent.dart';
// import 'package:omnichannel_flutter/modules/product/bloc/Product/ProductState.dart';
// import 'package:omnichannel_flutter/utis/Failure.dart';
//
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   ProductBloc() : super(CreateCateStateInitial());
//
//   @override
//   Stream<ProductState> mapEventToState(ProductEvent event) async* {
//     if (event is CreateCateEvent) {
//       Either<Failure, dynamic> res = await RemoteRepository.createCat(event.name);
//       if (res.isRight) {
//         return CreateCate
//       }
//     }
//   }
// }