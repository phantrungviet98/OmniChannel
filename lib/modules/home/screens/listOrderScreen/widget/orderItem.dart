import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/assets/png-jpg/PngJpg.dart';
import 'package:omnichannel_flutter/modules/home/screens/listOrderScreen/widget/ExpandItem.dart';

class OrderItem extends StatefulWidget {
  final String description;
  final String numberItem;
  final int status;
  final String idExport;
  final String sellOn;
  final String amount;
  final Function onPress;
  final String dateCreated;
  final String name;
  final String phoneNumber;
  final Function onPressOption;

  const OrderItem(
      {Key key,
      this.description = "",
      this.status,
      this.onPress,
      this.numberItem,
      this.idExport,
      this.dateCreated,
      this.sellOn,
      this.amount,
      this.name,
      this.phoneNumber,
      this.onPressOption,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: ExpansionTile(
          // trailing: SizedBox(),
          children: [
            ExpandItem(
              name: widget.name,
              phoneNumber: widget.phoneNumber,
            )
          ],
          tilePadding: EdgeInsets.all(0),
          title: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    offset: Offset(0, 8),
                    color: Color(0xffCCDFF2).withOpacity(0.17),
                  )
                ],
              ),
              margin: EdgeInsets.only(left: 4, bottom: 4),
              padding: EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Mã đơn hàng: ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            (widget.idExport == null || widget.idExport == "")
                                ? "1"
                                : widget.idExport,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () => widget.onPressOption(),
                        child: Container(
                          decoration: BoxDecoration(
                              color: convertStatusToColor(widget.status),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: EdgeInsets.only(
                              top: 3, left: 10, right: 10, bottom: 3),
                          child: Row(
                            children: [
                              Text(
                                convertStatusToString(widget.status),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "Bán hàng qua: ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      (widget.sellOn == null || widget.sellOn == "")
                          ? Text(
                              "Trực tiếp",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          : (widget.sellOn == "FB")
                              ? Image.asset(
                                  PngJpg.ic_face,
                                  width: 20,
                                  height: 20,
                                )
                              : (widget.sellOn == "Tiktok")
                                  ? Image.asset(
                                      PngJpg.ic_tiktok,
                                      width: 20,
                                      height: 20,
                                    )
                                  : Image.asset(
                                      PngJpg.ic_insta,
                                      width: 20,
                                      height: 20,
                                    ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Ngày tạo: ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            (widget.dateCreated == "" ||
                                    widget.dateCreated == null)
                                ? "chưa rõ"
                                : widget.dateCreated,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "Tổng tiền : ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        (widget.amount == null)
                            ? "0 đ"
                            : widget.amount.toString() + " đ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

extension Helper on _State {
  convertStatusToColor(int status) {
    switch (status) {
      case 1:
        return Colors.pinkAccent;
      case 2:
        return Colors.cyanAccent;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.green;
      case 5:
        return Colors.yellow;
    }
  }

  convertStatusToString(int status) {
    switch (status) {
      case 1:
        return 'Mới';
      case 2:
        return 'Đã xác nhận';
      case 3:
        return 'Đã gửi hàng';
      case 4:
        return 'Đã nhận';
      case 5:
        return 'Đang hoàn';
    }
  }
}
