import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omnichannel_flutter/config/client.dart';
import 'package:omnichannel_flutter/data/query/graphql_query.dart';

class PosService {
  static Future<dynamic> createCat() async {
    try {
      final result = await PosServiceConfigs.client.mutate(
        MutationOptions(
          document: gql(GraphQLQuery.createCat),
          fetchPolicy: FetchPolicy.noCache,
          variables: {"name": '123'},
          onError: (e) {print(e);}
        ),
      );
      print(result.toString());
    } catch (e) {
      throw ServerException();
    }
  }

  static Future<dynamic> getCategories() async {
    try {
      final result = await PosServiceConfigs.client.query(
        QueryOptions(document: gql(GraphQLQuery.getCategories), fetchPolicy: FetchPolicy.noCache
        )
      );
      print(result);
    } catch (e) {
      print(e);
    }
  }
}
