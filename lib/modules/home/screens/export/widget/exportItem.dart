import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExportItem extends StatelessWidget {
  final String description;
  final String createByName;
  final String numberItem;
  final String status;
  final String idExport;
  /// cái này để sau này chọn vào 1 đơn hàng nhảy ra màn detail của đơn hàng
  final Function onPress;
  final String warehouseName;
  final int quantity;

  const ExportItem(
      {Key key,
      this.description = "",
      this.createByName = "",
      this.status = "",
      this.onPress ,
      this.numberItem,
      this.idExport,
      this.warehouseName,
      this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 25,
              offset: Offset(0, 8),
              color: Color(0xffCCDFF2).withOpacity(0.17),
            )
          ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Mã đơn hàng: ",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Text(
                          (idExport == null || idExport == "") ? "1" : idExport,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Người tạo đơn: ",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Text(
                          (createByName == null || createByName == "") ? "Trâm Anh" : createByName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            "Kho xuất: ",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(
                                (warehouseName == "" || warehouseName == null) ? "chưa rõ" : warehouseName,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            "Số lượng : ",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            (quantity == null) ? "0" : quantity.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: (status == "NEW")
                              ? Color(0xff8D8E8F)
                              : (status == "ADVISING")
                                  ? Color(0xff35BA85)
                                  : (status == "WAIT_RECEIVE")
                                      ? Color(0xffE18700)
                                      : (status == "REJECT")
                                          ? Color(0xffD13029)
                                          : (status == "DONE_RECEIVE")
                                              ? Color(0xff2472FC)
                                              : Color(0xff515151),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.only(top: 3, left: 10, right: 10, bottom: 3),
                      child: Text(
                        (status == "NEW")
                            ? "Mới tạo"
                            : (status == "ADVISING")
                                ? "Đang chuyển"
                                : (status == "WAIT_RECEIVE")
                                    ? "Chờ nhận"
                                    : (status == "DONE_RECEIVE")
                                        ? "Đã nhận"
                                        : (status == "REJECT")
                                            ? "Từ chối nhận"
                                            : "Thất bại",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
