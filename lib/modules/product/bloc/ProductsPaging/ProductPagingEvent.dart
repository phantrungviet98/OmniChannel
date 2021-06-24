enum ProductPagingType { REFRESH, LOAD_MORE }

class ProductPagingEvent {
  const ProductPagingEvent(this.type);
  final ProductPagingType type;
}