import 'package:after_layout/after_layout.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:omnichannel_flutter/assets/png-jpg/PngJpg.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/data/modals/Order.dart';
import 'package:omnichannel_flutter/model/orderData.dart';
import 'package:omnichannel_flutter/modules/home/screens/listOrderScreen/widget/orderItem.dart';
import 'package:omnichannel_flutter/modules/order/bloc/OrderBloc.dart';
import 'package:omnichannel_flutter/modules/order/bloc/OrderEvent.dart';
import 'package:omnichannel_flutter/modules/order/bloc/OrderState.dart';
import 'package:omnichannel_flutter/utis/date.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");

class ListOrderScreen extends StatefulWidget {
  @override
  ListOrderScreenState createState() => ListOrderScreenState();
}

class ListOrderScreenState extends State<ListOrderScreen>
    with AfterLayoutMixin {
  List<OrderData> _listOderData = [];
  List<String> _listTitle = [];
  Map<dynamic, List<OrderData>> _dataOrderToShow;
  ScrollController controllerOrderData;

  void initState() {
    super.initState();
    _callApi();
  }

  void afterFirstLayout(BuildContext context) {
    // BlocProvider.of<OrderBloc>(context).add(OrdersPagingEvent(type: OrdersPagingType.refresh));
    _callApi();
  }

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

    // _generateSectionList(_listOderData);
  }

  _buildSectionList(List<Order> data) {
    final a = groupBy(
        data,
        (Order e) => convertMilisecToDateTimeReadable(
            e.dateCreated, DateFormat('dd/MM/yyyy')));
    final List<Widget> b = [];
    a.forEach((key, value) => b.add(buildSection(key, value)));
    return b;
  }

  onRefreshData() async {
    _listOderData.clear();
    _listTitle.clear();
    _dataOrderToShow.clear();
    _callApi();
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.3),
        decoration: BoxDecoration(
          color: AppColors.bone,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16)),
        ),
        child: Column(
          children: [
            InkWell(
              child: Text('Xác nhận đơn'),
              onTap: () {},
            ),
            InkWell(
              child: Text('Sửa đơn'),
              onTap: () {},
            ),
            InkWell(
              child: Text('Tạo bản sao'),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Order> listOrderData) {
    return SliverStickyHeader(
      header: Container(
        padding: const EdgeInsets.all(16),
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
              key: Key(item.id),
              onPress: () async {},
              onPressOption: () => _showBottomSheet(context),
              amount: formatCurrency.format(item.cod),
              description: convertCardItemsToDescription(item.cartItems),
              status: item.status,
              sellOn: item.conversationId != null ? 'FB' : null,
              idExport: item.itemId.toString(),
              dateCreated: convertMilisecToDateTimeReadable(
                  item.dateCreated, DateFormat('dd/MM/yyyy')),
              name: item.customerName,
              phoneNumber: item.phoneNumber,
            );
          },
          childCount: listOrderData.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Danh sách đơn hàng',
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.sage,
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
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) => _listOderData.length == 0
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
                    //margin: EdgeInsets.only(top: 15),
                    color: Color(0xffEFF4F7),
                    child: CustomScrollView(
                      controller: controllerOrderData,
                      slivers: _buildSectionList(state.ordersPaging.data.items),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

extension Helper on ListOrderScreenState {
  String convertCardItemsToDescription(List<CartItem> cartItems) {
    return cartItems
        .map((e) =>
            e.productName +
            e.attributes.map((e) => '${e.name}: ${e.value}').join(', '))
        .join('; ');
  }
}
