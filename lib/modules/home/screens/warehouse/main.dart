import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:omnichannel_flutter/assets/png-jpg/PngJpg.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/fonts/FontSize.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';
import 'package:omnichannel_flutter/modules/export/bloc/ExportBloc.dart';
import 'package:omnichannel_flutter/modules/export/bloc/ExportEvent.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/createExportScreen.dart';
import 'package:omnichannel_flutter/modules/home/screens/export/widget/exportItem.dart';
import 'package:omnichannel_flutter/modules/import/bloc/ImportBloc.dart';
import 'package:omnichannel_flutter/modules/import/bloc/ImportEvent.dart';
import "package:collection/collection.dart";
import 'package:omnichannel_flutter/modules/import/bloc/ImportState.dart';
import 'package:omnichannel_flutter/utis/date.dart';

class WarehouseScreen extends BaseScreenStateful {
  static final theme = ScreenTheme(
      color: AppColors.sage, title: 'Nhập kho', icon: Icons.move_to_inbox);

  @override
  State createState() {
    return _State();
  }
}

class _State extends State<WarehouseScreen>
    with AfterLayoutMixin<WarehouseScreen> {
  ScrollController controllerExportData;

  @override
  void afterFirstLayout(BuildContext context) {
    BlocProvider.of<ImportBloc>(context).add(ImportEventPaging());
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
                    BlocProvider.of<ImportBloc>(context)
                        .add(ImportEventCancelImport(id));
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
                  onTap: () {
                    BlocProvider.of<ImportBloc>(context)
                        .add(ImportEventCloneImport(id));
                    Navigator.pop(context);
                  },
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
              quantity: item.items.length,
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
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "/createExport",
            arguments: CreateImportExportType.IMPORT),
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
        },
        child: BlocBuilder<ImportBloc, ImportState>(
          builder: (context, state) {
            if (state.imports.items.length == 0) {
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
                        "Chưa có phiếu nhập kho",
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
                  onRefresh: () async => BlocProvider.of<ImportBloc>(context)
                      .add(ImportEventPaging()),
                  child: CustomScrollView(
                    controller: controllerExportData,
                    // slivers: _listTitle.map((title) => buildSection(title, _dataExportShow[title])).toList(),
                    slivers: _buildSectionList(state.imports.items),
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
