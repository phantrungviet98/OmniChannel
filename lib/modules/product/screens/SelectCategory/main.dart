import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Product/ProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Product/ProductEvent.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class SelectCategoryScreen extends BaseScreen {
  _openCreateCateForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 146,
            child: Column(
              children: [
                Padding(
                    child: Text('Tạo danh mục'),
                    padding: EdgeInsets.only(bottom: 10)),
                TextField(
                  decoration: InputDecoration(hintText: 'Tên danh mục'),
                ),
                Padding(
                  child: AppButton(
                    onPressed: () => BlocProvider.of<ProductBloc>(context).add(CreateCateEvent()),
                    title: 'Tạo',
                  ),
                  padding: EdgeInsets.only(top: 20)
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chọn danh mục sản phẩm',
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                _openCreateCateForm(context);
              },
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Text('Bạn chưa có danh mục nào'),
      ),
    );
  }
}
