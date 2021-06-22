import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/data/modals/Export.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({@required this.data});
  final List<StockExportItem> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Text('Trống');
    }
    
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(1),
        },
        children: [
          TableRow(decoration: BoxDecoration(color: AppColors.bone), children: [
            TableCell(child: Text('Tên sản phẩm')),
            TableCell(child: Text('Mẫu mã')),
            TableCell(child: Text('Số lượng')),
          ]),
          ...List.from(data
              .map((e) => TableRow(children: [
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(e.productName),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(''),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(e.qty.toString()),
                    )),
                  ]))
              .toList())
        ],
      ),
    );
  }
}
