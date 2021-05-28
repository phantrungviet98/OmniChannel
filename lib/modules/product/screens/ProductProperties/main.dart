import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductProperties/widgets/CreatePropertiesDialog.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductProperties/widgets/ProductPropertiesItem.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';
import 'package:trotter/trotter.dart';

class ProductProperties extends BaseScreenStateful {
  ProductProperties({this.onDone});

  final Function(List<Attributes>) onDone;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductProperties> {
  List<Variants> _variants = [];

  _openCreateCateForm(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CreatePropertiesDialog(
          onDone: (props) {
            final variants =
                props.map((e) => Variants(attributes: List.from([e])));
            setState(() {
              _variants.addAll(variants);
            });
          },
        );
      },
    );
  }

  c(List<List<String>> a, int index) {
    if (index == a.length) {
      return [];
    }

    log('a[index' + a[index].toString());
    log('123123 ' + ([...c(a, index + 1)]).toString());

    final l = a[index].map((e) => [e, c(a, index + 1)]).toList();
    return l;
    // return ;
  }
  // _a() {
  //   List<List<String>> list = [];
  //
  //   int count = 0;
  //
  //   List<List<String>> a = [['S', 'M'], ['S1', 'M1'], ['S2', 'M2']];
  //
  //
  //
  //   a.forEach((e) {
  //     List<String> s = [];
  //     e.forEach((element) {
  //       s.add();
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _a();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Thuộc tính sản phẩm',
        leading: InkWell(
          child: Icon(Icons.close),
          onTap: () => Navigator.pop(context),
        ),
        actions: [
          InkWell(
              child: Container(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Icon(
                      Icons.add,
                    ),
                  )),
              onTap: () {
                _openCreateCateForm(context);
              })
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _variants.length,
          itemBuilder: (context, index) {
            return ProductPropertiesItem(
              variant: _variants[index],
            );
          },
        ),
      ),
    );
  }
}
