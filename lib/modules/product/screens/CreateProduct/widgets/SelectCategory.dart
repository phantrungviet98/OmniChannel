import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductState.dart';

class SelectCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<SelectCategory> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductBloc, CreateProductState>(
      builder: (context, state) {
        log('123123' + state.createProductInput.cats.toString());
        return InkWell(
          onTap: () async {
            final result = await Navigator.pushNamed(context, '/select-category') as Cats;
            if (result != null) {
              BlocProvider.of<CreateProductBloc>(context).add(CreateProductEventChangeCategory(cate: result));
            }
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text(state.createProductInput.cats?.first?.name ?? 'Chọn danh mục'), Icon(Icons.arrow_right)],
            ),
            padding: EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
                border:
                Border(bottom: BorderSide(width: 1, color: AppColors.sage))),
          ),
        );
      }
    );
  }
}
