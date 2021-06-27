import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
import 'package:omnichannel_flutter/data/modals/Location.dart';

class OrdersPaging extends Equatable {
  OrdersPaging({
    this.count,
    this.items,
    this.pageInfo,
  });

  final int count;
  final List<Order> items;
  final PageInfo pageInfo;

  OrdersPaging copyWith({
    int count,
    List<Order> items,
    PageInfo pageInfo,
  }) =>
      OrdersPaging(
        count: count ?? this.count,
        items: items ?? this.items,
        pageInfo: pageInfo ?? this.pageInfo,
      );

  factory OrdersPaging.fromJson(Map<String, dynamic> json) => OrdersPaging(
        count: json["count"],
        items: List<Order>.from(json["items"].map((x) => Order.fromJson(x))),
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pageInfo": pageInfo.toJson(),
      };

  @override
  List<Object> get props => [count, items, pageInfo];
}

class Order extends Equatable {
  Order({
    this.id,
    this.itemId,
    this.minetype,
    this.customerName,
    this.phoneNumber,
    this.amount,
    this.cod,
    this.totalWeight,
    this.status,
    this.stockId,
    this.shippingPartnerId,
    this.dateCreated,
    this.conversationId,
    this.chanelId,
    this.cartItems,
    this.address,
    this.cityCode,
    this.districtCode,
    this.wardCode,
    this.ward,
    this.city,
    this.district,
    this.shippingCode,
    this.shippingFee,
  });

  final String id;
  final int itemId;
  final int minetype;
  final String customerName;
  final String phoneNumber;
  final int amount;
  final int cod;
  final int totalWeight;
  final int status;
  final String stockId;
  final String shippingPartnerId;
  final int dateCreated;
  final String conversationId;
  final dynamic chanelId;
  final List<CartItem> cartItems;
  final String address;
  final int cityCode;
  final int districtCode;
  final int wardCode;
  final Ward ward;
  final City city;
  final District district;
  final String shippingCode;
  final ShippingFee shippingFee;

  Order copyWith({
    String id,
    int itemId,
    int minetype,
    String customerName,
    String phoneNumber,
    int amount,
    int cod,
    int totalWeight,
    int status,
    String stockId,
    String shippingPartnerId,
    int dateCreated,
    String conversationId,
    dynamic chanelId,
    List<CartItem> cartItems,
    String address,
    int cityCode,
    int districtCode,
    int wardCode,
    Ward ward,
    City city,
    District district,
    String shippingCode,
    ShippingFee shippingFee,
  }) =>
      Order(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        minetype: minetype ?? this.minetype,
        customerName: customerName ?? this.customerName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        amount: amount ?? this.amount,
        cod: cod ?? this.cod,
        totalWeight: totalWeight ?? this.totalWeight,
        status: status ?? this.status,
        stockId: stockId ?? this.stockId,
        shippingPartnerId: shippingPartnerId ?? this.shippingPartnerId,
        dateCreated: dateCreated ?? this.dateCreated,
        conversationId: conversationId ?? this.conversationId,
        chanelId: chanelId ?? this.chanelId,
        cartItems: cartItems ?? this.cartItems,
        address: address ?? this.address,
        cityCode: cityCode ?? this.cityCode,
        districtCode: districtCode ?? this.districtCode,
        wardCode: wardCode ?? this.wardCode,
        ward: ward ?? this.ward,
        city: city ?? this.city,
        district: district ?? this.district,
        shippingCode: shippingCode ?? this.shippingCode,
        shippingFee: shippingFee ?? this.shippingFee,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        itemId: json["id"],
        minetype: json["minetype"],
        customerName: json["customer_name"],
        phoneNumber: json["phone_number"],
        amount: json["amount"],
        cod: json["COD"],
        totalWeight: json["total_weight"],
        status: json["status"],
        stockId: json["stock_id"],
        shippingPartnerId: json["shipping_partner_id"] == null
            ? null
            : json["shipping_partner_id"],
        dateCreated: json["date_created"],
        conversationId:
            json["conversation_id"] == null ? null : json["conversation_id"],
        chanelId: json["chanel_id"],
        cartItems: List<CartItem>.from(
            json["cart_items"].map((x) => CartItem.fromJson(x))),
        address: json["address"] == null ? null : json["address"],
        cityCode: json["city_code"] == null ? null : json["city_code"],
        districtCode:
            json["district_code"] == null ? null : json["district_code"],
        wardCode: json["ward_code"] == null ? null : json["ward_code"],
        ward: json["ward"] == null ? null : Ward.fromJson(json["ward"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        district: json["district"] == null
            ? null
            : District.fromJson(json["district"]),
        shippingCode:
            json["shipping_code"] == null ? null : json["shipping_code"],
        shippingFee: json["shipping_fee"] == null
            ? null
            : ShippingFee.fromJson(json["shipping_fee"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": itemId,
        "minetype": minetype,
        "customer_name": customerName,
        "phone_number": phoneNumber,
        "amount": amount,
        "COD": cod,
        "total_weight": totalWeight,
        "status": status,
        "stock_id": stockId,
        "shipping_partner_id":
            shippingPartnerId == null ? null : shippingPartnerId,
        "date_created": dateCreated,
        "conversation_id": conversationId == null ? null : conversationId,
        "chanel_id": chanelId,
        "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
        "address": address == null ? null : address,
        "city_code": cityCode == null ? null : cityCode,
        "district_code": districtCode == null ? null : districtCode,
        "ward_code": wardCode == null ? null : wardCode,
        "ward": ward == null ? null : ward.toJson(),
        "city": city == null ? null : city.toJson(),
        "district": district == null ? null : district.toJson(),
        "shipping_code": shippingCode == null ? null : shippingCode,
        "shipping_fee": shippingFee == null ? null : shippingFee.toJson(),
      };

  @override
  List<Object> get props => [
        id,
        itemId,
        minetype,
        customerName,
        phoneNumber,
        amount,
        cod,
        totalWeight,
        status,
        stockId,
        shippingPartnerId,
        dateCreated,
        conversationId,
        chanelId,
        cartItems,
        address,
        cityCode,
        districtCode,
        wardCode,
        ward,
        city,
        district,
        shippingCode,
        shippingFee
      ];
}

class CartItem extends Equatable {
  CartItem({
    this.productIdRef,
    this.qty,
    this.price,
    this.weight,
    this.productName,
    this.attributes,
  });

  final String productIdRef;
  final int qty;
  final int price;
  final int weight;
  final String productName;
  final List<Attribute> attributes;

  CartItem copyWith({
    String productIdRef,
    int qty,
    int price,
    int weight,
    String productName,
    List<Attribute> attributes,
  }) =>
      CartItem(
        productIdRef: productIdRef ?? this.productIdRef,
        qty: qty ?? this.qty,
        price: price ?? this.price,
        weight: weight ?? this.weight,
        productName: productName ?? this.productName,
        attributes: attributes ?? this.attributes,
      );

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productIdRef: json["product_id_ref"],
        qty: json["qty"],
        price: json["price"],
        weight: json["weight"],
        productName: json["product_name"],
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id_ref": productIdRef,
        "qty": qty,
        "price": price,
        "weight": weight,
        "product_name": productName,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [productIdRef, qty, price, weight, productName, attributes];
}

class Attribute extends Equatable {
  Attribute({
    this.name,
    this.value,
  });

  final String name;
  final String value;

  Attribute copyWith({
    String name,
    String value,
  }) =>
      Attribute(
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };

  @override
  List<Object> get props => [name, value];
}

class ShippingFee extends Equatable {
  ShippingFee({
    this.fee,
  });

  final int fee;

  ShippingFee copyWith({
    int fee,
  }) =>
      ShippingFee(
        fee: fee ?? this.fee,
      );

  factory ShippingFee.fromJson(Map<String, dynamic> json) => ShippingFee(
        fee: json["fee"],
      );

  Map<String, dynamic> toJson() => {
        "fee": fee,
      };

  @override
  // TODO: implement props
  List<Object> get props => [fee];
}