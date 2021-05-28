import 'package:either_option/either_option.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';
import 'package:omnichannel_flutter/data/modals/LoginResponse.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';
import 'package:omnichannel_flutter/data/services/auth_service.dart';
import 'package:omnichannel_flutter/data/services/pos_service.dart';
import 'package:omnichannel_flutter/utis/Failure.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class RemoteRepository {
  static Future<Either<Failure, LoginResponse>>login(String username, String password) async {
    try {
      final json = await AuthService.login(username, password);
      return Right(json);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  static Future<Either<Failure, dynamic>>createCat(String name) async {
    try {
      final data = await PosService.createCat(name);
      return Right(data);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  static Future<Either<Failure, GetAllCateResponse>>getCategories() async {
    try {
      final data = await PosService.getCategories();
      return Right(data);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  static Future<Either<Failure, List<Product>>>getAllProducts() async {
    try {
      final data = await PosService.getAllProducts();
      return Right(data);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}