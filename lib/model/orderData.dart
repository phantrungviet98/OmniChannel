class OrderData {
  String orderId;
  String warehouseId;
  String warehouseName;
  String createById;
  String createByName;
  String createAt;
  String description;
  int totalItem;
  List<String> listItem;
  String status;
  int totalAmount;
  String sellOn;

  OrderData({
    this.orderId,
    this.warehouseId,
    this.warehouseName,
    this.createById,
    this.createByName,
    this.description,
    this.totalItem,
    this.listItem,
    this.status,
    this.createAt,
    this.totalAmount,
    this.sellOn,
  });

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['exportId']??'';
    warehouseId = json['warehouseId']??'';
    warehouseName = json['warehouseName']??'';
    createById = json['createById']??'';
    createByName = json['createByName']??'';
    description = json['description']??'';
    totalItem = json['totalItem']??'';
    listItem = json['listItem']??'';
    status = json['status']??'';
    createAt = json['createAt']??'';
    totalAmount = json['totalAmount']??'';
    sellOn = json['sellOn']??'';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['exportId'] = this.orderId;
    data['warehouseId'] = this.warehouseId;
    data['warehouseName'] = this.warehouseName;
    data['createById'] = this.createById;
    data['createByName'] = this.createByName;
    data['description'] = this.description;
    data['totalItem'] = this.totalItem;
    data['listItem'] = this.listItem;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    data['totalAmount'] = this.totalAmount;
    data['sellOn'] = this.sellOn;


    return data;
  }
}
