import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductState.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductProperties/main.dart';

class ProductProperties extends StatefulWidget {
  const ProductProperties({
      this.onAttributeChange});
  final Function(ProductPropertiesChangedParams) onAttributeChange;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductProperties> {
  final _focusNode = FocusNode();

  _onPress() async {
    _focusNode.unfocus();
    final result = await Navigator.pushNamed(context, '/product-properties');
    widget.onAttributeChange(result);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductBloc, CreateProductState>(builder: (context, state) => Column(
      children: [
        Text(
          'Thuộc tính sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
            () {
          if (state.createProductInput.attributes.isEmpty) {
            return TextFormField(
              focusNode: _focusNode..unfocus(),
              onTap: _onPress,
              decoration: InputDecoration(
                  hintText: 'Thêm thuộc tính sản phẩm của bạn ở đây',
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.sage,
                  )),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: _onPress,
                    child: Text('Dữ liệu đã được cập nhật', style: TextStyle(color: AppColors.languidLavender),),
                  )
                ],
              ),
            );
          }
        }(),
      ],
    ),);
  }
}
