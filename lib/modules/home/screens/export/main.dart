import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:omnichannel_flutter/assets/png-jpg/PngJpg.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';
import 'package:omnichannel_flutter/model/ExportData.dart';
import "package:collection/collection.dart";
import 'package:omnichannel_flutter/modules/home/screens/export/widget/exportItem.dart';

class ExportScreen extends BaseScreenStateful {
  static final theme = ScreenTheme(color: Colors.blueAccent, title: 'Nhập kho', icon: Icons.move_to_inbox);

  @override
  ExportScreenState createState() => ExportScreenState();
}

class ExportScreenState extends State<ExportScreen> {
  List<ExportData> _listExportData = [];
  List<String> _listTitle =[];
  Map<dynamic, List<ExportData>> _dataExportShow;
  ScrollController controllerExportData;

  void initState(){
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
    ExportData exportData = new ExportData(exportId: "DH100",
      warehouseId: "7",
      warehouseName: "kho 2",
      createById: "1",
      createByName: "admin",
      description: "Xuất kho hàng nam",
      totalItem: 2,
      status: "DONE_RECEIVE",
      createAt:"08/06/2021"
    );
    ExportData exportData2 = new ExportData(exportId: "DH001",
        warehouseId: "1",
        warehouseName: "kho 9",
        createById: "1",
        createByName: "admin phụ",
        description: "Xuất 400 bao tay",
        totalItem: 9,
        status: "NEW",
        createAt:"31/05/2021"
    );
    ExportData exportData3 = new ExportData(exportId: "DH333",
        warehouseId: "1",
        warehouseName: "kho 3",
        createById: "1",
        createByName: "Trâm Anh",
        description: "Xuất 2 cái mũ",
        totalItem: 1000,
        status: "REJECT",
        createAt:"30/04/1975"
    );
    _listExportData.add(exportData);
    _listExportData.add(exportData);
    _listExportData.add(exportData);
    _listExportData.add(exportData3);
    _listExportData.add(exportData2);
    _listExportData.add(exportData3);
    _listExportData.add(exportData2);
    _listExportData.add(exportData2);
    _listExportData.add(exportData2);
    _listExportData.add(exportData);
    _listExportData.add(exportData3);
    _listExportData.add(exportData);
    _listExportData.add(exportData);
    _listExportData.add(exportData2);
    _listExportData.add(exportData3);
    _listExportData.add(exportData2);
    _listExportData.add(exportData2);
    _listExportData.add(exportData2);
    _listExportData.add(exportData);
    _listExportData.add(exportData);
    _listExportData.add(exportData3);
    _listExportData.add(exportData);
    _listExportData.add(exportData2);
    _listExportData.add(exportData2);
    _listExportData.add(exportData3);
    _listExportData.add(exportData2);
    _listExportData.add(exportData2);
    _generateSectionList(_listExportData);
  }
  ///hàm này để group lại dữ liệu theo ngày tháng
  _generateSectionList(List<ExportData> listExportData) {
    _listTitle.clear();
    _dataExportShow = groupBy(listExportData, (ExportData e) {
      return e.createAt;
    });
    if (_dataExportShow != null) {
      _dataExportShow.forEach((key, value) {
        _listTitle.add(key);
      });
    }
  }
  onRefreshData() async {
    _listExportData.clear();
    _listTitle.clear();
    _dataExportShow.clear();
    _callApi();
  }
  Widget buildSection(String title, List<ExportData> listExportData) {
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
            var item = listExportData[index];
            return ExportItem(
              /// để mở ra màn detail
                onPress: () async {
                  print("ok");
                },

                description: item.description,
                status: item.status,
                quantity: item.totalItem,
                createByName: item.createByName,
                idExport: item.exportId,
                warehouseName: item.warehouseName,

               );
          },
          childCount: listExportData.length,
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
          controller: controllerExportData,
          slivers: _listTitle.map((title) => buildSection(title, _dataExportShow[title])).toList(),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    /// app chưa có willpop
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add),
        onPressed: () async{
          final result = await Navigator.pushNamed(context, "/createExport");
         if(result == true){
           onRefreshData();
         }
        },
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
        },
        child: _listExportData.length == 0
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
                  "Chưa có phiếu xuất kho",
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
          margin: EdgeInsets.only(top: 15),
          color: Color(0xffEFF4F7),
          child: CustomScrollView(
            controller: controllerExportData,
            slivers: _listTitle.map((title) => buildSection(title, _dataExportShow[title])).toList(),
          ),
        ),
      ),
    );
  }
}
