import 'package:equatable/equatable.dart';
import 'package:omnichannel_flutter/data/modals/Stock.dart';

// also used for import

class ExportsPaging extends Equatable {
  ExportsPaging({
    this.count,
    this.items,
    this.pageInfo,
  });

  final int count;
  final List<StockExport> items;
  final PageInfo pageInfo;

  ExportsPaging copyWith({
    int count,
    List<StockExport> items,
    PageInfo pageInfo,
  }) =>
      ExportsPaging(
        count: count ?? this.count,
        items: items ?? this.items,
        pageInfo: pageInfo ?? this.pageInfo,
      );

  static get empty => ExportsPaging(count: 0, items: [], pageInfo: PageInfo.empty);

  factory ExportsPaging.fromJson(Map<String, dynamic> json) => ExportsPaging(
    count: json["count"],
    items: List<StockExport>.from(json["items"].map((x) => StockExport.fromJson(x))),
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

class StockExport extends Equatable {
  StockExport({
    this.items,
    this.createdByUser,
    this.id,
    this.itemId,
    this.note,
    this.stockId,
    this.type,
    this.createdBy,
    this.dateCreated,
    this.status,
    this.stock,
  });

  final List<StockExportItem> items;
  final CreatedByUser createdByUser;
  final String id;
  final int itemId;
  final String note;
  final String stockId;
  final int type;
  final String createdBy;
  final int dateCreated;
  final int status;
  final Stock stock;

  StockExport copyWith({
    List<StockExportItem> items,
    CreatedByUser createdByUser,
    String id,
    int itemId,
    String note,
    String stockId,
    int type,
    String createdBy,
    int dateCreated,
    int status,
    Stock stock,
  }) =>
      StockExport(
        items: items ?? this.items,
        createdByUser: createdByUser ?? this.createdByUser,
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        note: note ?? this.note,
        stockId: stockId ?? this.stockId,
        type: type ?? this.type,
        createdBy: createdBy ?? this.createdBy,
        dateCreated: dateCreated ?? this.dateCreated,
        status: status ?? this.status,
        stock: stock ?? this.stock,
      );

  factory StockExport.fromJson(Map<String, dynamic> json) => StockExport(
    items: List<StockExportItem>.from(json["items"].map((x) => StockExportItem.fromJson(x))),
    createdByUser: CreatedByUser.fromJson(json["created_by_user"]),
    id: json["_id"],
    itemId: json["id"],
    note: json["note"],
    stockId: json["stock_id"],
    type: json["type"],
    createdBy: json["created_by"],
    dateCreated: json["date_created"],
    status: json["status"],
    stock: Stock.fromJson(json["stock"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "created_by_user": createdByUser.toJson(),
    "_id": id,
    "id": itemId,
    "note": note,
    "stock_id": stockId,
    "type": type,
    "created_by": createdBy,
    "date_created": dateCreated,
    "status": status,
    "stock": stock.toJson(),
  };

  @override
  List<Object> get props => [items, createdByUser, id, itemId, note, stockId, type, createdBy, dateCreated, status, stock];
}

class CreatedByUser extends Equatable {
  CreatedByUser({
    this.id,
    this.displayName,
    this.username,
  });

  final String id;
  final String displayName;
  final String username;

  CreatedByUser copyWith({
    String id,
    String displayName,
    String username,
  }) =>
      CreatedByUser(
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        username: username ?? this.username,
      );

  factory CreatedByUser.fromJson(Map<String, dynamic> json) => CreatedByUser(
    id: json["_id"],
    displayName: json["display_name"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "display_name": displayName,
    "username": username,
  };

  @override
  List<Object> get props => [id, displayName, username];
}

class StockExportItem extends Equatable {
  StockExportItem({
    this.productIdRef,
    this.productName,
    this.variantId,
    this.attribute,
    this.qty,
    this.id,
  });

  final String productIdRef;
  final String productName;
  final int variantId;
  final String attribute;
  final int qty;
  final String id;

  StockExportItem copyWith({
    String productIdRef,
    String productName,
    int variantId,
    String attribute,
    int qty,
    String id,
  }) =>
      StockExportItem(
        productIdRef: productIdRef ?? this.productIdRef,
        productName: productName ?? this.productName,
        variantId: variantId ?? this.variantId,
        attribute: attribute ?? this.attribute,
        qty: qty ?? this.qty,
        id: id ?? this.id,
      );

  factory StockExportItem.fromJson(Map<String, dynamic> json) => StockExportItem(
    productIdRef: json["product_id_ref"],
    productName: json["product_name"],
    variantId: json["variant_id"],
    attribute: json["attribute"],
    qty: json["qty"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id_ref": productIdRef,
    "product_name": productName,
    "variant_id": variantId,
    "attribute": attribute,
    "qty": qty,
    "_id": id,
  };

  @override
  List<Object> get props => [productIdRef, productName, variantId, attribute, qty, id];
}

class PageInfo extends Equatable {
  PageInfo({
    this.currentPage,
    this.pageCount,
    this.itemCount,
    this.hasNextPage,
  });

  final int currentPage;
  final int pageCount;
  final int itemCount;
  final bool hasNextPage;

  PageInfo copyWith({
    int currentPage,
    int pageCount,
    int itemCount,
    bool hasNextPage,
  }) =>
      PageInfo(
        currentPage: currentPage ?? this.currentPage,
        pageCount: pageCount ?? this.pageCount,
        itemCount: itemCount ?? this.itemCount,
        hasNextPage: hasNextPage ?? this.hasNextPage,
      );

  static get empty => PageInfo(currentPage: 0, pageCount: 0, hasNextPage: false, itemCount: 0);

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    currentPage: json["currentPage"],
    pageCount: json["pageCount"],
    itemCount: json["itemCount"],
    hasNextPage: json["hasNextPage"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "pageCount": pageCount,
    "itemCount": itemCount,
    "hasNextPage": hasNextPage,
  };

  @override
  List<Object> get props => [currentPage, pageCount, itemCount, hasNextPage];
}
