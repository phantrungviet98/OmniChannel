import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';

class LookupProductModal {
  const LookupProductModal(
      {this.name,
      this.attributes,
      this.price,
      this.variantId,
      this.productIdRef});

  final String name;
  final List<Attributes> attributes;
  final int variantId;
  final int price;
  final String productIdRef;
}
