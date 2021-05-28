import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';

class ProductPropertiesScreenParams {
  const ProductPropertiesScreenParams();
}

class ProductProperties extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductProperties> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Thuộc tính sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _controller,
          focusNode: _focusNode..unfocus(),
          onTap: () async {
            _focusNode.unfocus();
            final result = await Navigator.pushNamed(context, '/product-properties', arguments: ProductPropertiesScreenParams());
            _controller.text = result.toString();
            // widget.onChanged(result);
            _focusNode.unfocus();
          },
          decoration: InputDecoration(hintText: 'Thêm thuộc tính sản phẩm của bạn ở đây', icon: Icon(Icons.edit, color: AppColors.sage,)),
        ),
      ],
    );
  }
}
