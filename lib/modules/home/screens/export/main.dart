import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:omnichannel_flutter/assets/png-jpg/PngJpg.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/fonts/FontSize.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';
import "package:collection/collection.dart";
import 'package:omnichannel_flutter/modules/export/bloc/ExportBloc.dart';
import 'package:omnichannel_flutter/modules/export/bloc/ExportEvent.dart';
import 'package:omnichannel_flutter/modules/export/bloc/ExportState.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/createExportScreen.dart';
import 'package:omnichannel_flutter/modules/home/screens/export/widget/exportItem.dart';
import 'package:omnichannel_flutter/utis/date.dart';
import 'package:omnichannel_flutter/widgets/FullScreenLoading/main.dart';

class ExportScreen extends BaseScreenStateful {
  static final theme =
      ScreenTheme(color: AppColors.sage, title: 'Xuất kho', icon: Icons.outbox);

  @override
  ExportScreenState createState() => ExportScreenState();
}

class ExportScreenState extends State<ExportScreen>
    with AfterLayoutMixin<ExportScreen> {
  ScrollController controllerExportData;

  void initState() {
    super.initState();
    // _callApi();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    BlocProvider.of<ExportBloc>(context).add(ExportEventPaging());
  }

  List<Widget> _buildSectionList(List<StockExport> data) {
    final a = groupBy(
        data,
        (StockExport e) => convertMilisecToDateTimeReadable(
            e.dateCreated, DateFormat('dd/MM/yyyy')));
    final List<Widget> b = [];
    a.forEach((key, value) => b.add(buildSection(key, value)));
    return b;
  }

  onRefreshData() async {}

  Widget buildBottomSheetModal(String id) {
    return Container(
      color: AppColors.bone,
      height: 200,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    BlocProvider.of<ExportBloc>(context)
                        .add(ExportEventCancelExport(id));
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Hủy phiếu',
                      style:
                          TextStyle(color: Colors.red, fontSize: FontSize.big),
                    ),
                  )),
              InkWell(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Tạo bản sao',
                  style: TextStyle(fontSize: FontSize.big),
                ),
              )),
              InkWell(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'In mã vạch',
                  style: TextStyle(fontSize: FontSize.big),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, List<StockExport> listExportData) {
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
              onPress: () async {
                print("ok");
              },
              onPressStatus: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => buildBottomSheetModal(item.id),
                );
              },
              description: item.stock.name,
              status: item.status.toString(),
              quantity: item.items.fold(0, (t, element) => t + element.qty),
              createByName: item.createdByUser.displayName,
              idExport: item.itemId.toString(),
              warehouseName: item.stock.name,
              note: item.note,
              dateCreated: item.dateCreated,
              products: item.items ?? [],
            );
          },
          childCount: listExportData.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.sage,
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "/createExport",
            arguments: CreateImportExportType.EXPORT),
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
        },
        child: BlocBuilder<ExportBloc, ExportState>(
          builder: (context, state) {
            if (state.exports.items.length == 0) {
              if (state.status == Status.loading) {
                return FullScreenLoading();
              }
              return Center(
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
              );
            } else {
              return Container(
                padding: EdgeInsets.only(top: 15),
                color: Color(0xffEFF4F7),
                child: RefreshIndicator(
                  onRefresh: () async => BlocProvider.of<ExportBloc>(context)
                      .add(ExportEventPaging()),
                  child: CustomScrollView(
                    controller: controllerExportData,
                    // slivers: _listTitle.map((title) => buildSection(title, _dataExportShow[title])).toList(),
                    slivers: [
                      ..._buildSectionList(state.exports.items),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
