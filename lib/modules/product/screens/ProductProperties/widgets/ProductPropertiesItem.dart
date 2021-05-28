import 'package:flutter/cupertino.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';

class ProductPropertiesItem extends StatelessWidget {
  const ProductPropertiesItem({this.variant});

  final Variants variant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _FieldItem(
              name: 'Thuộc tính',
              value:
                  '${variant.attributes.first.name} ${variant.attributes.first.value}',
            ),
            _FieldItem(
              name: 'Trọng lượng',
              value: '',
            ),
            _FieldItem(name: 'Mã vạch', value: ''),
          ],
        ),
        Row(
          children: [
            _FieldItem(
              name: 'Giá bán',
              value: '',
            ),
            _FieldItem(name: 'Giá giảm', value: ''),
            _FieldItem(name: 'Giá nhập', value: ''),
          ],
        ),
      ],
    );
  }
}

class _FieldItem extends StatelessWidget {
  const _FieldItem({this.name, this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text('$name: $value'));
  }
}
