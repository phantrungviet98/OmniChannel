import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataBloc.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Account/AccountBloc.dart';
import 'package:omnichannel_flutter/modules/auth/bloc/Login/LoginBloc.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateCate/CreateCateBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductBloc.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockBloc.dart';

getBlocProviders(BuildContext context) {
  return [
    BlocProvider<AccountBloc>(create: (context) => AccountBloc()),
    BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(accountBloc: BlocProvider.of<AccountBloc>(context))),
    BlocProvider(create: (context) => CategoryBloc()),
    BlocProvider<CreateCateBloc>(
        create: (context) => CreateCateBloc(
            categoryBloc: BlocProvider.of<CategoryBloc>(context))),
    BlocProvider<GetAllProductBloc>(create: (context) => GetAllProductBloc()),
    BlocProvider<CreateProductBloc>(create: (context) => CreateProductBloc()),
    BlocProvider<StorehouseBloc>(create: (context) => StorehouseBloc()),
    BlocProvider<LocationDataBloc>(create: (context) => LocationDataBloc()),
    BlocProvider<CreateStockBloc>(
        create: (context) =>
            CreateStockBloc(BlocProvider.of<LocationDataBloc>(context))),
  ];
}
