import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:omnichannel_flutter/assets/png-jpg/PngJpg.dart';
import 'package:omnichannel_flutter/model/orderData.dart';
import 'package:omnichannel_flutter/modules/home/screens/listOrderScreen/widget/orderItem.dart';

class ListOrderScreen extends StatefulWidget {
  @override
  ListOrderScreenState createState() => ListOrderScreenState();
}

class ListOrderScreenState extends State<ListOrderScreen> {
  List<OrderData> _listOderData = [];
  List<String> _listTitle = [];
  Map<dynamic, List<OrderData>> _dataOrderToShow;
  ScrollController controllerOrderData;

  void initState() {
    super.initState();
    _callApi();
  }

  ///hàm này sẽ dùng khi có API sau
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    _callApi();
  }

  /// sau này sẽ call API ở dây tạm thời mình fix call API cần async await
  _callApi() {
    OrderData order1 = new OrderData(
        orderId: "DH100",
        warehouseId: "7",
        warehouseName: "kho 2",
        createById: "1",
        createByName: "admin",
        description: "Bán hàng qua mạng",
        totalItem: 2,
        totalAmount: 400000,
        sellOn: "FB",
        status: "DONE_RECEIVE",
        createAt: "08/06/2021");
    OrderData order2 = new OrderData(
        orderId: "DH001",
        warehouseId: "1",
        warehouseName: "kho 9",
        totalAmount: 24514,
        createById: "1",
        createByName: "admin phụ",
        description: "Bán hàng qua mạng",
        totalItem: 9,
        sellOn: "Insta",
        status: "WAIT_RECEIVE",
        createAt: "31/05/2021");
    OrderData order3 = new OrderData(
        orderId: "DH333",
        warehouseId: "1",
        warehouseName: "kho 3",
        createById: "1",
        createByName: "Trâm Anh",
        description: "Bán hàng online",
        totalItem: 1000,
        sellOn: "Tiktok",
        status: "REJECT",
        totalAmount: 454554,
        createAt: "30/04/1975");
    OrderData order4 = new OrderData(
        orderId: "DH13123",
        warehouseId: "1",
        warehouseName: "kho 3",
        createById: "1",
        createByName: "Trâm Anh",
        description: "Bán hàng tại quầy",
        totalItem: 1000,
        sellOn: "",
        totalAmount: 1000,
        status: "DONE",
        createAt: "30/04/1975");
    _listOderData.add(order1);
    _listOderData.add(order3);
    _listOderData.add(order2);
    _listOderData.add(order4);
    _listOderData.add(order1);
    _listOderData.add(order3);
    _listOderData.add(order2);
    _listOderData.add(order4);
    _listOderData.add(order1);
    _listOderData.add(order3);
    _listOderData.add(order2);
    _listOderData.add(order4);
    _listOderData.add(order1);
    _listOderData.add(order3);
    _listOderData.add(order2);
    _listOderData.add(order4);

    _generateSectionList(_listOderData);
  }

  ///hàm này để group lại dữ liệu theo ngày tháng
  _generateSectionList(List<OrderData> listOrderData) {
    _listTitle.clear();
    _dataOrderToShow = groupBy(listOrderData, (OrderData e) {
      return e.createAt;
    });
    if (_dataOrderToShow != null) {
      _dataOrderToShow.forEach((key, value) {
        _listTitle.add(key);
      });
    }
  }

  onRefreshData() async {
    _listOderData.clear();
    _listTitle.clear();
    _dataOrderToShow.clear();
    _callApi();
  }

  Widget buildSection(String title, List<OrderData> listOrderData) {
    return SliverStickyHeader(
      header: Container(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        color: Color(0xffEFF4F7),
        child: Row(
          children: [
            Text(
              "Ngày " + title,
              style: TextStyle(
                fontSize: 12,
                //fontFamily: I,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            var item = listOrderData[index];
            return OrderItem(
              /// để mở ra màn detail
              onPress: () async {
                print("ok");
              },
              amount: item.totalAmount.toString(),
              description: item.description,
              status: item.status,
              sellOn: item.sellOn,
              quantity: item.totalItem,
              createByName: item.createByName,
              idExport: item.orderId,
              warehouseName: item.warehouseName,
            );
          },
          childCount: listOrderData.length,
        ),
      ),
    );
  }

  Widget buildListData() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      color: Color(0xffEFF4F7),
      child: RefreshIndicator(
        onRefresh: onRefreshData,
        child: CustomScrollView(
          controller: controllerOrderData,
          slivers: _listTitle.map((title) => buildSection(title, _dataOrderToShow[title])).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// app chưa có willpop
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Danh sách đơn hàng"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, "/createOrder");
          if (result == true) {
            onRefreshData();
          }
        },
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
        },
        child: _listOderData.length == 0
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 90),
                  child: Column(
                    children: [
                      Image.asset(
                        PngJpg.imgNullData,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Chưa có đơn hàng",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
          padding: EdgeInsets.only(top: 15),
                //margin: EdgeInsets.only(top: 15),
                color: Color(0xffEFF4F7),
                child: CustomScrollView(
                  controller: controllerOrderData,
                  slivers: _listTitle.map((title) => buildSection(title, _dataOrderToShow[title])).toList(),
                ),
              ),
      ),
    );
  }
}
