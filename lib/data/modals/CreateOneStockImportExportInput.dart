import 'package:equatable/equatable.dart';

class CreateOneStockImportExportInput extends Equatable {
  CreateOneStockImportExportInput({
    this.stockId,
    this.note,
    this.items,
  });

  final String stockId;
  final String note;
  final List<StockImportExportItemInput> items;

  CreateOneStockImportExportInput copyWith({
    String stockId,
    String note,
    List<StockImportExportItemInput> items,
  }) =>
      CreateOneStockImportExportInput(
        stockId: stockId ?? this.stockId,
        note: note ?? this.note,
        items: items ?? this.items,
      );

  factory CreateOneStockImportExportInput.fromJson(Map<String, dynamic> json) => CreateOneStockImportExportInput(
    stockId: json["stock_id"],
    note: json["note"],
    items: List.from(json["items"].map((x) => StockImportExportItemInput.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "stock_id": stockId,
    "note": note,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [stockId, note, items];
}


class StockImportExportItemInput extends Equatable {
  StockImportExportItemInput({
    this.productName,
    this.productIdRef,
    this.variantId,
    this.qty,
  });

  final String productName;
  final String productIdRef;
  final int variantId;
  final int qty;

  StockImportExportItemInput copyWith({
    String productName,
    String productIdRef,
    int variantId,
    int qty,
  }) =>
      StockImportExportItemInput(
        productName: productName ?? this.productName,
        productIdRef: productIdRef ?? this.productIdRef,
        variantId: variantId ?? this.variantId,
        qty: qty ?? this.qty,
      );

  factory StockImportExportItemInput.fromJson(Map<String, dynamic> json) =>
      StockImportExportItemInput(
        productIdRef: json["product_id_ref"],
        variantId: json["variant_id"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "product_id_ref": productIdRef,
        "variant_id": variantId,
        "qty": qty,
      };

  @override
  List<Object> get props => [productName, productIdRef, variantId, qty];
}
