import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omnichannel_flutter/config/client.dart';
import 'package:omnichannel_flutter/data/modals/LoginResponse.dart';
import 'package:omnichannel_flutter/data/query/graphql_query.dart';

class AuthService {
  static Future<LoginResponse> login(String username, String password) async {
    try {
      final result = await AuthServiceConfigs.client.query(QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(GraphQLQuery.login),
          variables: {"username": username, "password": password}));
      return LoginResponse.fromJson(result.data['auth']['login']);
    } catch (e) {
      throw ServerException();
    }
  }
}