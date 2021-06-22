import 'dart:developer';
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/utis/number.dart';

class Product extends Equatable {
  String id;
  String name;
  Null desc;
  double price;
  Null inPrice;
  int salePrice;
  int weight;
  List<String> catIds;
  Null brandId;
  List<String> tagIds = [];
  bool men;
  bool women;
  bool boy;
  bool girl;
  List<Variants> variants = [];
  List<Attributes> attributes = [];
  String createdBy;
  int dateCreated;
  Null dateUpdated;
  Null updatedBy;
  List<String> photoIds;
  bool isActive;
  FeaturedPhoto featuredPhoto;
  ProductStock stockData;
  List<dynamic> tags = [];
  List<Photo> photos = [];
  CreatedByUser createdByUser;
  Null brand;
  List<Cats> cats = [];

  Product(
      {this.id,
      this.name,
      this.desc,
      this.price,
      this.inPrice,
      this.salePrice,
      this.weight,
      this.catIds,
      this.brandId,
      this.tagIds,
      this.men,
      this.women,
      this.boy,
      this.girl,
      this.variants,
      this.attributes,
      this.createdBy,
      this.dateCreated,
      this.dateUpdated,
      this.updatedBy,
      this.photoIds,
      this.isActive,
      this.featuredPhoto,
      this.stockData,
      this.tags,
      this.photos,
      this.createdByUser,
      this.brand,
      this.cats});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    desc = json['desc'];
    price = jsonToDouble(json['price']);
    inPrice = json['in_price'];
    salePrice = json['sale_price'];
    weight = json['weight'];
    catIds = json['cat_ids']?.cast<String>();
    brandId = json['brand_id'];
    if (json['tag_ids'] != null) {
      json['tag_ids'].forEach((v) {
        tagIds.add(v);
      });
    }
    men = json['men'];
    women = json['women'];
    boy = json['boy'];
    girl = json['girl'];
    if (json['variants'] != null) {
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    createdBy = json['created_by'];
    dateCreated = json['date_created'];
    dateUpdated = json['date_updated'];
    updatedBy = json['updated_by'];
    photoIds = json['photo_ids']?.cast<String>();
    isActive = json['is_active'];
    featuredPhoto = json['featured_photo'] != null
        ? new FeaturedPhoto.fromJson(json['featured_photo'])
        : null;
    if (json['stockData'] != null) {
      stockData = ProductStock.fromJson(json['stockData']);
    }
    if (json['tags'] != null) {
      json['tags'].forEach((v) {
        tags.add(v);
      });
    }
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        photos.add(Photo.fromJson(v));
      });
    }
    createdByUser = json['created_by_user'] != null
        ? new CreatedByUser.fromJson(json['created_by_user'])
        : null;
    brand = json['brand'];
    if (json['cats'] != null) {
      json['cats'].forEach((v) {
        cats.add(new Cats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['in_price'] = this.inPrice;
    data['sale_price'] = this.salePrice;
    data['weight'] = this.weight;
    data['cat_ids'] = this.catIds;
    data['brand_id'] = this.brandId;
    if (this.tagIds != null) {
      data['tag_ids'] = this.tagIds.toList();
    }
    data['men'] = this.men;
    data['women'] = this.women;
    data['boy'] = this.boy;
    data['girl'] = this.girl;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['created_by'] = this.createdBy;
    data['date_created'] = this.dateCreated;
    data['date_updated'] = this.dateUpdated;
    data['updated_by'] = this.updatedBy;
    data['photo_ids'] = this.photoIds;
    data['is_active'] = this.isActive;
    if (this.featuredPhoto != null) {
      data['featured_photo'] = this.featuredPhoto.toJson();
    }
    data['stockData'] = this.stockData;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.createdByUser != null) {
      data['created_by_user'] = this.createdByUser.toJson();
    }
    data['brand'] = this.brand;
    if (this.cats != null) {
      data['cats'] = this.cats.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object> get props => [
        id,
        name,
        desc,
        price,
        inPrice,
        salePrice,
        weight,
        catIds,
        brandId,
        tagIds,
        men,
        women,
        boy,
        girl,
        variants,
        attributes,
        createdBy,
        dateCreated,
        dateUpdated,
        updatedBy,
        photoIds,
        isActive,
        featuredPhoto,
        stockData,
        tags,
        photos,
        createdByUser,
        brand,
        cats
      ];
}

class ProductStock {
  int total;
  dynamic qtyByStock;
  dynamic qtyByVariant;

  ProductStock({this.total, this.qtyByStock, this.qtyByVariant});

  ProductStock.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    qtyByStock = json['qty_by_stock'];
    qtyByVariant = json['qty_by_variant'];
  }
}

class Variants {
  int id;
  int weight;
  int price;
  Null inPrice;
  int salePrice;
  String barcode;
  List<Attributes> attributes = [];

  Variants(
      {this.id,
      this.weight,
      this.price,
      this.inPrice,
      this.salePrice,
      this.barcode,
      this.attributes});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = json['weight'];
    price = json['price'];
    inPrice = json['in_price'];
    salePrice = json['sale_price'];
    barcode = json['barcode'];
    if (json['attributes'] != null) {
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weight'] = this.weight;
    data['price'] = this.price;
    data['in_price'] = this.inPrice;
    data['sale_price'] = this.salePrice;
    data['barcode'] = this.barcode;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes extends Equatable {
  String name;
  String value;

  Attributes({this.name, this.value});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }

  @override
  List<Object> get props => [name, value];
}

class FeaturedPhoto {
  String url;
  String origin;
  int dateCreated;
  String createdBy;
  bool isActive;

  FeaturedPhoto(
      {this.url, this.origin, this.dateCreated, this.createdBy, this.isActive});

  FeaturedPhoto.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    origin = json['origin'];
    dateCreated = json['date_created'];
    createdBy = json['created_by'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['origin'] = this.origin;
    data['date_created'] = this.dateCreated;
    data['created_by'] = this.createdBy;
    data['is_active'] = this.isActive;
    return data;
  }
}

class CreatedByUser {
  String displayName;
  String email;
  String username;
  String userRole;
  bool isActive;
  int dateCreated;

  CreatedByUser(
      {this.displayName,
      this.email,
      this.username,
      this.userRole,
      this.isActive,
      this.dateCreated});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    email = json['email'];
    username = json['username'];
    userRole = json['user_role'];
    isActive = json['is_active'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['user_role'] = this.userRole;
    data['is_active'] = this.isActive;
    data['date_created'] = this.dateCreated;
    return data;
  }
}

class Cats {
  String name;
  Null parentId;
  List<String> ancestorIds = [];

  Cats({this.name, this.parentId, this.ancestorIds});

  Cats.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    parentId = json['parent_id'];
    if (json['ancestor_ids'] != null) {
      json['ancestor_ids'].forEach((v) {
        ancestorIds.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    if (this.ancestorIds != null) {
      data['ancestor_ids'] = this.ancestorIds.map((v) => v).toList();
    }
    return data;
  }
}

class Photo {
  String url;
  String origin;
  Float dateCreated;
  String createdBy;
  bool isActive;

  Photo(
      {this.url, this.origin, this.dateCreated, this.createdBy, this.isActive});

  Photo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    origin = json['origin'];
    dateCreated = json['date_created'];
    createdBy = json['created_by'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['origin'] = this.origin;
    data['date_created'] = this.dateCreated;
    data['created_by'] = this.createdBy;
    data['is_active'] = this.isActive;
    return data;
  }
}
