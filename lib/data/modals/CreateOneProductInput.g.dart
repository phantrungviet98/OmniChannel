// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreateOneProductInput.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension CreateOneProductInputCopyWith on CreateOneProductInput {
  CreateOneProductInput copyWith({
    List<ProductAttributesInput> attributes,
    bool boy,
    List<String> catIds,
    String desc,
    bool girl,
    double inPrice,
    bool men,
    String name,
    List<String> photoIds,
    List<String> photoUrls,
    double price,
    double salePrice,
    List<String> tagNames,
    List<Variants> variants,
    double weight,
    bool women,
  }) {
    return CreateOneProductInput(
      attributes: attributes ?? this.attributes,
      boy: boy ?? this.boy,
      catIds: catIds ?? this.catIds,
      desc: desc ?? this.desc,
      girl: girl ?? this.girl,
      inPrice: inPrice ?? this.inPrice,
      men: men ?? this.men,
      name: name ?? this.name,
      photoIds: photoIds ?? this.photoIds,
      photoUrls: photoUrls ?? this.photoUrls,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      tagNames: tagNames ?? this.tagNames,
      variants: variants ?? this.variants,
      weight: weight ?? this.weight,
      women: women ?? this.women,
    );
  }
}
