import 'dart:async';
import 'dart:developer';

import 'package:either_option/either_option.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omnichannel_flutter/config/client.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';
import 'package:omnichannel_flutter/data/modals/Location.dart';
import 'package:omnichannel_flutter/data/modals/LoginResponse.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';
import 'package:omnichannel_flutter/data/modals/Stock.dart';
import 'package:omnichannel_flutter/data/services/auth_service.dart';
import 'package:omnichannel_flutter/data/services/pos_service.dart';
import 'package:omnichannel_flutter/utis/Failure.dart';
import 'package:omnichannel_flutter/data/modals/Location.dart' as LocationModal;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class RemoteRepository {
  static Future<Either<Failure, LoginResponse>> login(
      String username, String password) async {
    try {
      final json = await AuthService.login(username, password);
      return Right(json);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  static Future<Either<Failure, dynamic>> createCat(String name) async {
    try {
      final data = await PosService.createCat(name);
      return Right(data);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  static Future<Either<Failure, GetAllCateResponse>> getCategories() async {
    try {
      final data = await PosService.getCategories();
      return Right(data);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  static Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final data = await PosService.getAllProducts();
      return Right(data);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  static Future<Either<Failure, bool>> createProduct(
      CreateOneProductInput input) async {
    try {
      await PosService.createProduct(input);
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }

  static Future<List<Stock>> getStocks() async {
    try {
      final result =
          await PosServiceConfigs.client.query(QueryOptions(document: gql('''
         query {
            stock {
              stocks {
                _id
                name
                phone_number
                address
                ward_code
                district_code
                city_code
                is_primary
                is_active
                created_by
                date_created
                date_updated
                updated_by
                city {
                  _id
                  label
                }
                district {
                  _id
                  label
                  city_code
                }
                ward {
                  _id
                  label
                  city_code
                  district_code
                }
              }
            }
          }  
      '''), fetchPolicy: FetchPolicy.cacheAndNetwork));

      log(result.toString());

      List<Stock> list = List.from(
          result.data['stock']['stocks']?.map((e) => Stock.fromJson(e)));
      return list;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<City>> getCities() async {
    try {
      final result = await ShippingServiceConfigs.client
          .query(QueryOptions(document: gql('''
        query {
          location {
            cities {
              _id,
              label
            }
          }
        }
      ''')));
      return List.from(
          result.data['location']['cities']?.map((e) => City.fromJson(e)));
    } catch (e) {
      throw e;
    }
  }

  static Future<List<District>> getDistricts(int cityCode) async {
    try {
      final result = await ShippingServiceConfigs.client.query(QueryOptions(
          document: gql('''
        query(\$filter: FilterFindManyDistrictInput!) {
          location {
            districts(filter: \$filter) {
              _id,
              label
            }
          }
        }
      '''),
          variables: {
            'filter': FilterFindManyDistrictInput(cityCode: cityCode).toJson()
          }));
      log(result.toString());
      return List.from(result.data['location']['districts']
          ?.map((e) => District.fromJson(e)));
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  static Future<List<Ward>> getWards(int districtCode) async {
    try {
      final result = await ShippingServiceConfigs.client.query(
          QueryOptions(document: gql('''
        query(\$filter: FilterFindManyWardInput!) {
          location {
            wards(filter: \$filter) {
              _id,
              label
            }
          }
        }
      '''), variables: {
        'filter': FilterFindManyWardInput(districtCode: districtCode).toJson()
      }));
      return List.from(
          result.data['location']['wards']?.map((e) => Ward.fromJson(e)));
    } catch (e) {
      throw e;
    }
  }

  static Future<String> createStock(CreateOneStockInput data) async {
    try {
      final result = await PosServiceConfigs.client
          .mutate(MutationOptions(document: gql('''
          mutation(\$record: CreateOneStockInput!) {
            stock {
              createStock(record: \$record) {
                recordId
              }
            }
          }
        '''), variables: {'record': data.toJson()}));
      return result.data['stock']['createStock']['recordId'];
    } catch (e) {
      throw e;
    }
  }

  static Future<String> updateStock(String id, CreateOneStockInput data) async {
    try {
      final result = await PosServiceConfigs.client
          .mutate(MutationOptions(document: gql('''
            mutation(\$id: String, \$record: UpdateOneStockInput!) {
              stock {
                updateStock(filter: {_id: \$id}, record: \$record) {
                  recordId
                }
              }
            }
          '''), variables: {'id': id, 'record': data}));
      log('updateStock' + result.toString());
      return result.data['stock']['updateStock']['recordId'];
    } catch (e) {
      log('updateStockerr' + e.toString());
      throw e;
    }
  }
}
