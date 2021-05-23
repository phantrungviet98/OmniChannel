import 'package:either_option/either_option.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omnichannel_flutter/data/modals/LoginResponse.dart';
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

  static Future<Either<Failure, dynamic>>createCat() async {
    try {
      final json = await PosService.createCat();
      return Right(json);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  static Future<Either<Failure, dynamic>>getCategories() async {
    try {
      final json = await PosService.getCategories();
      return Right(json);
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}