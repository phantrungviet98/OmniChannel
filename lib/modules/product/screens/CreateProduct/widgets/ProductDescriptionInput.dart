import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductDescription/main.dart';

class ProductDescriptionInput extends StatefulWidget {
  const ProductDescriptionInput({this.onChanged});

  final Function(String) onChanged;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductDescriptionInput>
    with AfterLayoutMixin<ProductDescriptionInput> {
  final _controller = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    BlocProvider.of<CreateProductBloc>(context).stream.listen((state) {
      _controller.text = state.createProductInput.desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Mô tả sản phẩm',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(

          maxLines: 10,
          minLines: 2,
          readOnly: true,
          controller: _controller,
          onTap: () async {
            final result = await Navigator.pushNamed(
                context, '/product-description',
                arguments:
                    ProductDescriptionScreenParams(text: _controller.text));
            _controller.text = result.toString();
            widget.onChanged(result);
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.edit, color: AppColors.sage),
            hintText: 'Nhập mô tả sản phẩm của bạn ở đây',
          ),
        )
      ],
    );
  }
}
