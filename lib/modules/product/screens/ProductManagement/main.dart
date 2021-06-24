import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:omnichannel_flutter/assets/json/JsonAnimates.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/GetAllProduct/GetAllProductState.dart';
import 'package:omnichannel_flutter/modules/product/bloc/ProductsPaging/ProductPagingBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/ProductsPaging/ProductPagingEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/ProductsPaging/ProductPagingState.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Quản lý sản phẩm',
      ),
      body: BlocProvider<ProductPagingBloc>(
        create: (context) => ProductPagingBloc(),
        child: BlocBuilder<ProductPagingBloc, ProductPagingState>(
          builder: (context, state) {
            if (state.products.isNotEmpty) {
              return RefreshIndicator(
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (scrollEnd) {
                      var metrics = scrollEnd.metrics;
                      if (metrics.atEdge) {
                        if (metrics.pixels == 0)
                          print('At top');
                        else
                          BlocProvider.of<ProductPagingBloc>(context).add(
                              ProductPagingEvent(ProductPagingType.LOAD_MORE));
                      }
                      return true;
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(top: 10),
                          sliver: SliverGrid(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                                final product = state.products[index];
                                return ProductItem(
                                  sId: product.id,
                                  id: product.productId,
                                  photo: product.photos.isNotEmpty
                                      ? product.photos.first.url
                                      : '',
                                  name: product.name,
                                  price: product.price,
                                  total: product.stockData?.total ?? 0,
                                  dateCreated: product.dateCreated,
                                );
                              }, childCount: state.products.length),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 3 / 4)),
                        ),
                        SliverToBoxAdapter(
                          child: state.pageInfo.hasNextPage
                              ? SizedBox(
                                  height: 59,
                                  child:
                                      Lottie.asset(JsonAnimates.loadingCircles),
                                )
                              : SizedBox(height: 10,),
                        )
                      ],
                    ),
                  ),
                  onRefresh: () async =>
                      BlocProvider.of<ProductPagingBloc>(context)
                          .add(ProductPagingEvent(ProductPagingType.REFRESH)));
            }
            return Center(
              child: Lottie.asset(JsonAnimates.loadingCircles, height: 100),
            );
          },
        ),
      ),
    );
  }
}
