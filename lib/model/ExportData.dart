class ExportData {
  String exportId;
  String warehouseId;
  String warehouseName;
  String createById;
  String createByName;
  String createAt;
  String description;
  int totalItem;
  List<String> listItem;
  String status;


  ExportData({
   this.exportId,
    this.warehouseId,
    this.warehouseName,
    this.createById,
    this.createByName,
    this.description,
    this.totalItem,
    this.listItem,
    this.status,
    this.createAt,
  });

  ExportData.fromJson(Map<String, dynamic> json) {
    exportId = json['exportId']??'';
    warehouseId = json['warehouseId']??'';
    warehouseName = json['warehouseName']??'';
    createById = json['createById']??'';
    createByName = json['createByName']??'';
    description = json['description']??'';
    totalItem = json['totalItem']??'';
    listItem = json['listItem']??'';
    status = json['status']??'';
    createAt = json['createAt']??'';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['exportId'] = this.exportId;
    data['warehouseId'] = this.warehouseId;
    data['warehouseName'] = this.warehouseName;
    data['createById'] = this.createById;
    data['createByName'] = this.createByName;
    data['description'] = this.description;
    data['totalItem'] = this.totalItem;
    data['listItem'] = this.listItem;
    data['status'] = this.status;
    data['createAt'] = this.createAt;


    return data;
  }
}
