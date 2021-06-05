import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omnichannel_flutter/config/client.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';
import 'package:omnichannel_flutter/data/query/graphql_query.dart';

class PosService {
  static Future<dynamic> createCat(String name) async {
    try {
      final result = await PosServiceConfigs.client.mutate(
        MutationOptions(
            document: gql(GraphQLQuery.createCat),
            fetchPolicy: FetchPolicy.noCache,
            variables: {"name": name},
            onError: (e) {
              print(e);
            }),
      );
      print(result.toString());
    } catch (e) {
      throw ServerException();
    }
  }

  static Future<GetAllCateResponse> getCategories() async {
    try {
      final result = await PosServiceConfigs.client.query(QueryOptions(
          document: gql(GraphQLQuery.getCategories),
          fetchPolicy: FetchPolicy.noCache));
      return GetAllCateResponse.fromJson(result.data['product']);
    } catch (e) {
      throw ServerException();
    }
  }

  static Future<List<Product>> getAllProducts() async {
    try {
      final result = await PosServiceConfigs.client.query(QueryOptions(
          document: gql(GraphQLQuery.getAllProducts),
          fetchPolicy: FetchPolicy.noCache));
      final List<Product> products = [];
      if (result.data['product']['products'] != null) {
        result.data['product']['products'].forEach((e) {
          products.add(Product.fromJson(e));
        });
      }
      return products;
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }

  static Future<bool> createProduct(CreateOneProductInput input) async {
    try {
      final result = await PosServiceConfigs.client.mutate(MutationOptions(
          document: gql(GraphQLQuery.createProduct),
          fetchPolicy: FetchPolicy.noCache,
          variables: {"record": input.toJson()},
          onError: (e) {
            print('createProductError' + e.toString());
          }));
      return true;
    } catch (e) {
      throw ServerException();
    }
  }
}
