class GraphQLQuery {
  static const login = """
    query(\$username: String!, \$password: String!) {
      auth {
        login(username: \$username, password: \$password) {
          accessToken,
          userData {display_name},
          error {message}
        }
      }
    }
  """;

  static const getCategories = """
    query {
      product {
        cats {
          name
          parent_id
          _id
          ancestor_ids
        }
      }
    }
  """;

  static const createCat = """
    mutation(\$name: String!) {
      product {
        createCat(record: {name: \$name}) {
  	      record {
            _id,
            name,
            parent_id,
            ancestor_ids,
          }
  	    }
      }
    }
  """;
}