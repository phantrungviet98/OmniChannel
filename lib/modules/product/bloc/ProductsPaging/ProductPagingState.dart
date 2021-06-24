import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';

class ProductPagingState extends Equatable {
  const ProductPagingState(
      {this.status, this.perPage, this.products, this.pageInfo});

  final Status status;
  final int perPage;
  final List<Product> products;
  final PageInfo pageInfo;

  ProductPagingState copyWith(
          {Status status, int perPage, List<Product> products, PageInfo pageInfo}) =>
      ProductPagingState(
        status: status ?? this.status,
        perPage: perPage ?? this.perPage,
        products: products ?? this.products,
        pageInfo: pageInfo ?? this.pageInfo,
      );

  @override
  List<Object> get props => [status, perPage, products, pageInfo];
}
