import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
import 'package:omnichannel_flutter/modules/home/screens/export/widget/ProductTable.dart';
import 'package:omnichannel_flutter/utis/date.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';

class ExportItem extends StatelessWidget {
  final String description;
  final String createByName;
  final String numberItem;
  final String status;
  final String idExport;
  final Function onPress;
  final Function onPressStatus;
  final String warehouseName;
  final int quantity;
  final int dateCreated;
  final String note;
  final List<StockExportItem> products;

  const ExportItem(
      {Key key,
      this.description = "",
      this.createByName = "",
      this.status = "",
      this.onPress,
      this.onPressStatus,
      this.numberItem,
      this.idExport,
      this.warehouseName,
      this.quantity,
      this.dateCreated,
      this.note = "",
      this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 25,
                  offset: Offset(0, 8),
                  color: Color(0xffCCDFF2).withOpacity(0.17),
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
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
                          style:
                              TextStyle(fontSize: 16, color: Colors.blueAccent),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Mã phiếu: ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            Text(
                              (idExport == null || idExport == "")
                                  ? "1"
                                  : idExport,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Tạo bởi: ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            Text(
                              (createByName == null || createByName == "")
                                  ? "Trâm Anh"
                                  : createByName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        dateCreated != null
                            ? Row(
                                children: [
                                  Text(
                                    "Ngày tạo: ",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  Text(
                                    convertMilisecToDateTimeReadable(
                                        dateCreated,
                                        DateFormat('hh:mm dd/MM/yyyy')),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Container(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         "Kho: ",
                        //         style: TextStyle(
                        //             fontSize: 14, color: Colors.black),
                        //       ),
                        //       Text(
                        //         (warehouseName == "" || warehouseName == null)
                        //             ? "chưa rõ"
                        //             : warehouseName,
                        //         style: TextStyle(
                        //             fontSize: 14,
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.w500),
                        //         overflow: TextOverflow.ellipsis,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Tổng số lượng: ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                (quantity == null) ? "0" : quantity.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppButton(
                          onPressed: onPressStatus,
                          title: (status == "NEW")
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
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ghi chú: ",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  Expanded(
                      child: Text(
                    note ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
                ],
              ),
              ProductTable(
                data: products,
              )
            ],
          )),
    );
  }
}
