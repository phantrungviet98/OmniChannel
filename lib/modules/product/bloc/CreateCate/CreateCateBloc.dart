import 'package:bloc/bloc.dart';
import 'package:either_option/either_option.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateCate/CreateCateEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateCate/CreateCateState.dart';
import 'package:omnichannel_flutter/utis/Failure.dart';

class CreateCateBloc extends Bloc<CreateCateEvent, CreateCateState> {
  CreateCateBloc({this.categoryBloc}) : super(CreateCateStateInitial());

  final CategoryBloc categoryBloc;

  @override
  Stream<CreateCateState> mapEventToState(CreateCateEvent event) async* {
    yield CreateCateStateLoading();
    Either<Failure, dynamic> res = await RemoteRepository.createCat(event.name);
    if (res.isRight) {
      categoryBloc.add(CategoryEventGetAll());
      yield CreateCateStateSuccess();
    } else {
      yield CreateCateStateFail();
    }
  }

}