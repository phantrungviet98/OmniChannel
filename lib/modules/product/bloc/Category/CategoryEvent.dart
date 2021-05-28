abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoryEventGetAll extends CategoryEvent {
  const CategoryEventGetAll();
}

class CategoryEventSearch extends CategoryEvent {
  const CategoryEventSearch({this.searchText});
  final String searchText;
}