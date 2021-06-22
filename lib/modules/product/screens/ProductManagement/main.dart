import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductState.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductManagement/widgets/ProductItem.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';
import 'package:omnichannel_flutter/widgets/FullScreenLoading/main.dart';

class ProductManagementScreen extends BaseScreenStateful {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductManagementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<GetAllProductBloc>(context).add(GetAllProductEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Quản lý sản phẩm',
      ),
      body: BlocBuilder<GetAllProductBloc, GetAllProductState>(
        builder: (context, state) {
          if (state is GetAllProductStateLoading) {
            return FullScreenLoading();
          }
          if (state is GetAllProductStateSuccess) {
            return GridView.builder(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3 / 4),
              itemBuilder: (context, index) {
                final product = state.products[index];

                log(product.toString());

                return ProductItem(
                  id: product.id,
                  photo:
                      product.photos.isNotEmpty ? product.photos.first.url : '',
                  name: product.name,
                  price: product.price,
                  total: product.stockData?.total ?? 0,
                  dateCreated: product.dateCreated,
                );
              },
              itemCount: state.products.length,
            );
          }
          return Center(
            child: Text('Không có sản phẩm nào'),
          );
        },
      ),
    );
  }
}
