import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/constant/Metrics.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockImportExportInput.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportBloc.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportEvent.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportState.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/widget/PickProductItem.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/widget/normal_text_input.dart';
import 'package:omnichannel_flutter/utis/ui/main.dart';

class PickProductDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(left: 16, right: 16),
      content: SizedBox(
        width: Metrics.getScreenWidth(context) * 0.9,
        child: Column(
          children: [
            NormalTextInput(
              hintText: 'Tìm kiếm sản phẩm',
              onChanged: (text) => _onChangeTextSearch(context, text),
            ),
            BlocBuilder<CreateImportExportBloc, CreateImportExportState>(
              builder: (context, state) {
                final products = state.lookup.data;
                log(products.toString());
                return Expanded(
                    child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return PickProductItem(
                      product: products[index],
                      onTap: () {
                        BlocProvider.of<CreateImportExportBloc>(context).add(
                            AddProduct(
                                StockImportExportItemInput(
                                    productName: product.name,
                                    qty: 1,
                                    variantId: product.variantId,
                                    productIdRef: product.productIdRef),
                                (isExisting) => showSnackBar(context, text: isExisting
                                    ? 'Đã cập nhật số lượng sản phẩm'
                                    : 'Đã thêm sản phẩm')));
                        Navigator.pop(context);
                      },
                    );
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  _onChangeTextSearch(BuildContext context, String text) {
    EasyDebounce.cancel('lookup-product');
    EasyDebounce.debounce('lookup-product', Duration(milliseconds: 500), () {
      BlocProvider.of<CreateImportExportBloc>(context).add(LookupProduct(text));
    });
  }
}
