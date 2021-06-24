import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';

class PropertiesTable extends StatelessWidget {
  const PropertiesTable({this.attributes, this.onAttributeChanged});

  final List<ProductAttributesInput> attributes;
  final Function(List<ProductAttributesInput>) onAttributeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Table(
        border: TableBorder.all(color: Colors.black12),
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
        },
        children: _buildTableRow(),
      ),
    );
  }

  _onRemoveAttribute(int index) {
    this.attributes.removeAt(index);
    onAttributeChanged(this.attributes);
  }

  _onRemoveValueOfAttribute(int attributeIndex, int valueIndex) {
    attributes[attributeIndex].values.removeAt(valueIndex);

    onAttributeChanged(this.attributes.where((e) => e.values.isNotEmpty).toList());
  }

  _buildTableRow() {
    List<TableRow> rows = List.from([
      TableRow(children: [
        TableCell(
            child: Container(
              color: AppColors.bone,
              padding: EdgeInsets.all(8),
              child: Text('Thuộc tính'),
            ),
            verticalAlignment: TableCellVerticalAlignment.middle),
        TableCell(
            child: Container(
          color: AppColors.bone,
          padding: EdgeInsets.all(8),
          child: Text('Giá trị'),
        )),
      ])
    ]);

    if (attributes != null && attributes.isNotEmpty) {
      attributes.asMap().forEach((index, element) {
        rows.add(TableRow(children: [
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                alignment: Alignment.center,
                child: Text(attributes[index].name),
              )),
          TableCell(
              child: Row(
            children: [
              Expanded(
                  child: Tags(
                horizontalScroll: true,
                itemCount: attributes[index].values.length,
                itemBuilder: (i) {
                  return ItemTags(
                    activeColor: AppColors.sage,
                    pressEnabled: false,
                    index: index,
                    title: attributes[index].values[i],
                    removeButton: ItemTagsRemoveButton(onRemoved: () {
                      _onRemoveValueOfAttribute(index, i);
                      return true;
                    }),
                  );
                },
              )),
              Container(
                margin: EdgeInsets.only(right: 12),
                child: InkWell(
                  child: Icon(
                    Icons.close,
                    color: Colors.redAccent,
                  ),
                  onTap: () => _onRemoveAttribute(index),
                ),
              )
            ],
          ))
        ]));
      });
    }

    return rows;
  }
}
