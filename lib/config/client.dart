import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ServiceConfigs {
  const ServiceConfigs();
}

class AuthServiceConfigs extends ServiceConfigs {
  static final HttpLink httpLink = HttpLink('https://auth-service-dev.azsales.vn/graphql');
  static GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
}

class PosServiceConfigs {
  static final HttpLink httpLink = HttpLink('https://pos-service-dev.azsales.vn/graphql');
  static String token = '';
  static final AuthLink authLink = AuthLink(headerKey: 'access_token', getToken: () => token);
  static final Link link = authLink.concat(httpLink);
  static GraphQLClient client = GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );
}

class ShippingServiceConfigs {
  static final HttpLink httpLink = HttpLink('https://shipping-service-dev.azsales.vn/graphql');
  static String token = '';
  static final AuthLink authLink = AuthLink(headerKey: 'access_token', getToken: () => token);
  static final Link link = authLink.concat(httpLink);
  static GraphQLClient client = GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );
}
