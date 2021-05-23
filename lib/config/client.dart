import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ServiceConfigs {
  const ServiceConfigs();
}

class AuthServiceConfigs extends ServiceConfigs {
  static final HttpLink httpLink = HttpLink('https://auth-service-dev.azsales.vn/graphql');
  static String token;
  static GraphQLClient client;
  static ValueNotifier<GraphQLClient> initializeClient() {
    AuthServiceConfigs.client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      AuthServiceConfigs.client,
    );
    return client;
  }
}

class PosServiceConfigs {
  static final HttpLink httpLink = HttpLink('https://pos-service-dev.azsales.vn/graphql');
  static String token;
  static final AuthLink authLink = AuthLink(getToken: () => token);
  // static final WebSocketLink websocketLink = WebSocketLink(
  //   url: '',
  //   config: SocketClientConfig(
  //     autoReconnect: true,
  //     inactivityTimeout: Duration(seconds: 30),
  //     initPayload: () async {
  //       return {
  //         'headers': {'Authorization': _token},
  //       };
  //     },
  //   ),
  // );
  static final Link link = authLink.concat(httpLink);


  static GraphQLClient client;

  static ValueNotifier<GraphQLClient> initializeClient() {
    PosServiceConfigs.client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      PosServiceConfigs.client,
    );
    return client;
  }
}
