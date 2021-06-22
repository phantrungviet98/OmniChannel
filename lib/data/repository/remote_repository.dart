import 'dart:async';
import 'dart:developer';

import 'package:either_option/either_option.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omnichannel_flutter/config/client.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockImportExportInput.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
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

  static Future<ExportsPaging> getExportsPaging(int page, int perPage) async {
    try {
      final result = await PosServiceConfigs.client.query(QueryOptions(
          document: gql('''
            query(\$page:Int, \$perPage:Int) {
              stock {
                 exportsPaging(page:\$page , perPage: \$perPage, sort:ID_DESC) {
                   count, items {
                     items { product_id_ref, product_name, variant_id, attribute, qty, _id},
                     created_by_user { _id, display_name, username },
                     _id, id, note, stock_id, type, created_by, date_created, status,
                     stock { name }
                   },
                   pageInfo { currentPage, pageCount, itemCount, hasNextPage }
                 }
              }
            }
          '''),
          variables: {'page': page, 'perPage': perPage},
          fetchPolicy: FetchPolicy.cacheAndNetwork));
      return ExportsPaging.fromJson(result.data['stock']['exportsPaging']);
    } catch (e) {
      log('getStocksPagingError' + e.toString());
      throw e;
    }
  }

  static Future<ExportsPaging> getImportsPaging(int page, int perPage) async {
    try {
      final result = await PosServiceConfigs.client.query(QueryOptions(
          document: gql('''
            query(\$page:Int, \$perPage:Int) {
              stock {
                 importsPaging(page:\$page , perPage: \$perPage, sort:ID_DESC) {
                   count, items {
                     items { product_id_ref, product_name, variant_id, attribute, qty, _id},
                     created_by_user { _id, display_name, username },
                     _id, id, note, stock_id, type, created_by, date_created, status,
                     stock { name }
                   },
                   pageInfo { currentPage, pageCount, itemCount, hasNextPage }
                 }
              }
            }
          '''),
          variables: {'page': page, 'perPage': perPage},
          fetchPolicy: FetchPolicy.cacheAndNetwork));

      log(result.toString());
      return ExportsPaging.fromJson(result.data['stock']['importsPaging']);
    } catch (e) {
      log('getImportsPaging' + e.toString());
      throw e;
    }
  }

  static Future<int> cancelExport(String id) async {
    try {
      final result = await PosServiceConfigs.client
          .mutate(MutationOptions(document: gql('''
            mutation(\$_id:String) {
              stock {
                 cancelExport(_id: \$_id) {
                    status
                 }
              }
            }
          '''), variables: {'_id': id}));
      log(result.toString());
      return int.parse(result.data['stock']['cancelExport']['status']);
    } catch (e) {
      throw e;
    }
  }

  static Future<int> cancelImport(String id) async {
    try {
      final result = await PosServiceConfigs.client
          .mutate(MutationOptions(document: gql('''
            mutation(\$_id:String) {
              stock {
                 cancelImport(_id: \$_id) {
                    status
                 }
              }
            }
          '''), variables: {'_id': id}));
      return int.parse(result.data['stock']['cancelImport']['status']);
    } catch (e) {
      throw e;
    }
  }

  static Future<StockExport> cloneImport(String id) async {
    try {
      final result = await PosServiceConfigs.client
          .mutate(MutationOptions(document: gql('''
            mutation cloneImport(\$_id: String) {
                stock {
                    cloneImport(_id: \$_id) {
                        items { product_id_ref, product_name, variant_id, attribute, qty, _id},
                        created_by_user { _id, display_name, username },
                        _id, id, note, stock_id, type, created_by, date_created, status,
                        stock { name }
                    }
                }
            }
          '''), variables: {'_id': id}));
      return StockExport.fromJson(result.data['stock']['cloneImport']);
    } catch (e) {
      throw e;
    }
  }

  static Future<StockExport> cloneExport(String id) async {
    try {
      final result = await PosServiceConfigs.client
          .mutate(MutationOptions(document: gql('''
            mutation cloneExport(\$_id: String) {
                stock {
                    cloneExport(_id: \$_id) {
                        items { product_id_ref, product_name, variant_id, attribute, qty, _id},
                        created_by_user { _id, display_name, username },
                        _id, id, note, stock_id, type, created_by, date_created, status,
                        stock { name }
                    }
                }
            }
          '''), variables: {'_id': id}));
      return StockExport.fromJson(result.data['stock']['cloneExport']);
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Product>> lookupProduct(String text) async {
    try {
      final result = await PosServiceConfigs.client.query(QueryOptions(
          document: gql('''
            query lookup(\$text:String){
                product {
                    lookup(text:\$text) {
                        _id, name, featured_photo {_id, url}, variants {
                          _id, id, weight, price, barcode, attributes {name, value}
                        }
                    }
                }
            }
          '''),
          variables: {'text': text},
          fetchPolicy: FetchPolicy.cacheAndNetwork));
      final List<Product> products = [];
      if (result.data['product']['lookup'] != null) {
        result.data['product']['lookup'].forEach((e) {
          products.add(Product.fromJson(e));
        });
      }
      return products;
    } catch (e) {
      throw e;
    }
  }

  static Future<bool> createImport(CreateOneStockImportExportInput record) async {
    try {
      final result = await PosServiceConfigs.client.mutate(MutationOptions(document: gql('''
        mutation (\$record:CreateOneStockImportInput!) {
                stock {
                    createImport(record: \$record) {
                        recordId
                    }
                  }
              }
      ''')));

      log('ress123123213' + result.toString());

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> createExport(CreateOneStockImportExportInput record) async {
    try {
      final result = await PosServiceConfigs.client.mutate(MutationOptions(document: gql('''
        mutation (\$record:CreateOneStockExportInput!) {
                stock {
                    createExport(record: \$record) {
                        recordId
                    }
                  }
              }
      '''), variables: {'record': record.toJson()}));

      log('ress123123213' + result.toString());

      return true;
    } catch (e) {
      return false;
    }
  }
}
