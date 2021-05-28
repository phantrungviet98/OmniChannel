import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductDescription/main.dart';

class ProductDescriptionInput extends StatefulWidget {
  const ProductDescriptionInput({this.onChanged});
  final Function(String) onChanged;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductDescriptionInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(bottom: 10), child: Text('Mô tả sản phẩm', style: TextStyle(fontWeight: FontWeight.bold),),),
        TextField(
          controller: _controller,
          focusNode: _focusNode..unfocus(),
          onTap: () async {
            _focusNode.unfocus();
            final result = await Navigator.pushNamed(context, '/product-description', arguments: ProductDescriptionScreenParams(text: _controller.text));
            _controller.text = result.toString();
            widget.onChanged(result);
            _focusNode.unfocus();
          },
          decoration: InputDecoration(hintText: 'Nhập mô tả sản phẩm của bạn ở đây', icon: Icon(Icons.edit, color: AppColors.sage,)),
        )
      ],
    );
  }
}