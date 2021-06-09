import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

class CreateOneProductInput extends Equatable {
  String name;
  double inPrice;
  double salePrice;
  String desc;
  double price;
  double weight;
  List<String> catIds;
  bool men;
  bool women;
  bool boy;
  bool girl;
  List<ProductAttributesInput> attributes;
  List<String> photoIds;
  List<String> tagNames;
  List<Variants> variants;
  List<String> photoUrls;

  CreateOneProductInput({
    this.name,
    this.inPrice,
    this.salePrice,
    this.desc,
    this.price,
    this.weight,
    this.catIds,
    this.men,
    this.women,
    this.boy,
    this.girl,
    this.attributes,
    this.photoIds,
    this.tagNames,
    this.variants,
    this.photoUrls,
  });

  static final empty = () => CreateOneProductInput(
      name: '',
      price: null,
      weight: null,
      tagNames: [],
      variants: [],
      attributes: [],
      catIds: [],
      desc: '',
      inPrice: null,
      men: false,
      women: false,
      boy: false,
      girl: false,
      photoIds: [],
      photoUrls: [],
      salePrice: null
  );

  CreateOneProductInput.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    inPrice = json['in_price'];
    salePrice = json['sale_price'];
    desc = json['desc'];
    price = json['price'];
    weight = json['weight'];
    catIds = json['cat_ids'].cast<String>();
    men = json['men'];
    women = json['women'];
    boy = json['boy'];
    girl = json['girl'];
    photoUrls = json['photo_urls'].cast<String>();
    if (json['attributes'] != null) {
      attributes = new List<ProductAttributesInput>();
      json['attributes'].forEach((v) {
        attributes.add(new ProductAttributesInput.fromJson(v));
      });
    }
    if (json['photo_ids'] != null) {
      photoIds = new List<Null>();
      json['photo_ids'].forEach((v) {
        photoIds.add(v);
      });
    }
    tagNames = json['tag_names'].cast<String>();
    if (json['variants'] != null) {
      variants = new List<Variants>();
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['in_price'] = this.inPrice;
    data['sale_price'] = this.salePrice;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['cat_ids'] = this.catIds;
    data['men'] = this.men;
    data['women'] = this.women;
    data['boy'] = this.boy;
    data['girl'] = this.girl;
    data['photo_urls'] = this.photoUrls;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    if (this.photoIds != null) {
      data['photo_ids'] = this.photoIds.toList();
    }
    data['tag_names'] = this.tagNames;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // CreateOneProductInput copyWith({
  //   String name,
  //   double inPrice,
  //   double salePrice,
  //   String desc,
  //   double price,
  //   double weight,
  //   List<String> catIds,
  //   bool men,
  //   bool women,
  //   bool boy,
  //   bool girl,
  //   List<ProductAttributesInput> attributes,
  //   List<String> photoIds,
  //   List<String> tagNames,
  //   List<Variants> variants,
  //   List<String> photoUrls,
  // }) => CreateOneProductInput(
  //   name: name ?? this.name,
  //   inPrice: inPrice ?? this.inPrice,
  //   salePrice: salePrice ?? this.salePrice,
  //   desc: desc ?? this.desc,
  //   price: price ?? this.price,
  //   weight: weight ?? this.weight,
  //   catIds: catIds ?? this.catIds,
  //   men: men ?? this.men,
  //   women:
  // );

  @override
  List<Object> get props =>
      [
        name,
        inPrice,
        salePrice,
        desc,
        price,
        weight,
        catIds,
        men,
        women,
        boy,
        girl,
        attributes,
        photoIds,
        tagNames,
        variants,
        photoUrls
      ];
}

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


class ProductAttributesInput extends Equatable {
  String sId;
  String name;
  List<String> values;

  ProductAttributesInput({this.sId, this.name, this.values});

  ProductAttributesInput.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['values'] = this.values;
    return data;
  }

  @override
  List<Object> get props => [sId, name, values];
}

class Variants extends Equatable {
  int id;
  double weight;
  double price;
  List<ProductVariantsAttributesInput> attributes;
  double inPrice;
  String barcode;
  double salePrice;

  Variants({this.id,
    this.weight,
    this.price,
    this.attributes,
    this.inPrice,
    this.barcode,
    this.salePrice});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = json['weight'];
    price = json['price'];
    if (json['attributes'] != null) {
      attributes = new List<ProductVariantsAttributesInput>();
      json['attributes'].forEach((v) {
        attributes.add(new ProductVariantsAttributesInput.fromJson(v));
      });
    }
    inPrice = json['in_price'];
    salePrice = json['sale_price'];
    barcode = json['barcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weight'] = this.weight;
    data['price'] = this.price;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['in_price'] = this.inPrice;
    data['sale_price'] = this.salePrice;
    data['barcode'] = this.barcode;
    return data;
  }

  @override
  List<Object> get props =>
      [id, weight, price, attributes, inPrice, barcode, salePrice];
}

class ProductVariantsAttributesInput extends Equatable {
  String sId;
  String name;
  String value;

  ProductVariantsAttributesInput({this.sId, this.name, this.value});

  ProductVariantsAttributesInput.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }

  @override
  List<Object> get props => [sId, name, value];
}
