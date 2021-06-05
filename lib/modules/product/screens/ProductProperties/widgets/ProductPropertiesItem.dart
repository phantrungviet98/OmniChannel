import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/constant/Metrics.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/utis/ui/Shadow.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';

class ProductPropertiesItem extends StatelessWidget {
  const ProductPropertiesItem({this.variants, this.onChangeVariant});

  final Variants variants;
  final Function(Variants) onChangeVariant;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [Shadow.light],
          color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              _FieldItem(
                name: '',
                value:
                    '${variants.attributes.map((e) => '${e.name}: ${e.value}').join('; ')}',
              ),
              _FieldItem(
                name: 'Trọng lượng',
                value: variants.weight.toString(),
              ),
            ],
          ),
          Row(
            children: [
              _FieldItem(name: 'Mã vạch', value: variants.barcode),
              _FieldItem(
                name: 'Giá bán',
                value: variants.price.toString(),
              ),
            ],
          ),
          Row(
            children: [
              _FieldItem(
                  name: 'Giá giảm', value: variants.salePrice.toString()),
              _FieldItem(name: 'Giá nhập', value: variants.inPrice.toString()),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => _onPressEdit(context),
                child: Icon(Icons.edit, color: AppColors.languidLavender),
              ),
              InkWell(
                  child: Icon(
                Icons.delete,
                color: Colors.red,
              ))
            ],
          )
        ],
      ),
    );
  }

  _onPressEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(16),
        title: Text('Sửa thuộc tính'),
        content: SizedBox(
          height: 400,
          width: Metrics.getScreenWidth(context) * 0.95,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Trọng lượng'),
                  initialValue: variants.weight != null ? variants.weight.toString() : '',
                onChanged: (text) => variants.weight = double.parse(text),
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Mã vạch'),
                initialValue: variants.barcode != null ? variants.barcode : '',
                onChanged: (text) => variants.barcode = text,
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Giá bán'),
                initialValue: variants.price != null ? variants.price.toString() : '',
                onChanged: (text) => variants.price = double.parse(text),
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Giá giảm'),
                initialValue: variants.salePrice != null ? variants.salePrice.toString() : '',
                onChanged: (text) => variants.salePrice = double.parse(text),
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Giá nhập'),
                initialValue: variants.inPrice != null ? variants.inPrice.toString() : '',
                onChanged: (text) => variants.inPrice = double.parse(text),
              ),
            ],
          ),
        ),
        actions: [
          AppButton(
            title: 'Lưu',
            onPressed: () {
              onChangeVariant(variants);
              Navigator.pop(context);
            },
          ),
          AppButton(
            title: 'Đóng',
            onPressed: () => Navigator.pop(context),
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}

class _FieldItem extends StatelessWidget {
  const _FieldItem({this.name, this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Text(
            '${name.isNotEmpty ? '$name: ' : ''}${value == null || value == 'null' || value.isEmpty ? 'Trống' : value}'));
  }
}
