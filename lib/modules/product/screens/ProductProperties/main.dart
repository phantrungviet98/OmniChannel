import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductProperties/widgets/CreatePropertiesDialog.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductProperties/widgets/ProductPropertiesItem.dart';
import 'package:omnichannel_flutter/modules/product/screens/ProductProperties/widgets/PropertiesTable.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class ProductPropertiesDefault {
  const ProductPropertiesDefault(
      {this.weight, this.price, this.inPrice, this.salePrice});

  final double weight;
  final double price;
  final double inPrice;
  final double salePrice;
}

class ProductPropertiesChangedParams {
  const ProductPropertiesChangedParams({this.variants, this.attributes});

  final List<Variants> variants;
  final List<ProductAttributesInput> attributes;
}

class ProductProperties extends BaseScreenStateful {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductProperties> {
  List<Variants> _variants = [];
  List<ProductAttributesInput> _attributes = [];

  _openCreateCateForm(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final bloc = BlocProvider.of<CreateProductBloc>(context);
        return CreatePropertiesDialog(
          onDone: (props) {
            _attributes.add(ProductAttributesInput(
                name: props.first.name,
                values: props.map((e) => e.value).toList()));
            _buildVariantsFromAttributes(_attributes, ProductPropertiesDefault(
              weight: bloc.state.createProductInput.weight,
              price: bloc.state.createProductInput.price,
              inPrice: bloc.state.createProductInput.inPrice,
              salePrice: bloc.state.createProductInput.salePrice,
            ));
          },
        );
      },
    );
  }

  _buildVariantsFromAttributes(List<ProductAttributesInput> attributes,
      ProductPropertiesDefault screenParams) {
    List<List<ProductVariantsAttributesInput>> a = _attributes
        .map((e) => e.values
            .map(
                (e1) => ProductVariantsAttributesInput(name: e.name, value: e1))
            .toList())
        .toList();
    if (a.isEmpty) {
      this.setState(() {
        _variants = [];
      });
      return;
    }

    List<List<ProductVariantsAttributesInput>> _allPossibleCases =
        allPossibleCases(a).toList();

    final variants = _allPossibleCases
        .map((e) => Variants(
            attributes: List.from(e),
            weight: screenParams.weight,
            price: screenParams.price,
            inPrice: screenParams.inPrice,
            salePrice: screenParams.salePrice))
        .toList();

    setState(() {
      _variants = variants;
    });
  }

  Iterable<List<ProductVariantsAttributesInput>> allPossibleCases(
      List<List<ProductVariantsAttributesInput>> list) sync* {
    List<List<ProductVariantsAttributesInput>> cloned = List.from(list);
    var first = cloned.removeAt(0);
    var remainder = cloned.isNotEmpty ? allPossibleCases(cloned) : [[]];
    for (var r in remainder) for (var h in first) yield [h, ...r];
  }

  // Iterable<List<String>> allPossibleCasesString(List<List<String>> list) sync* {
  //   List<List<String>> cloned = List.from(list);
  //   var first = cloned.removeAt(0);
  //   var remainder = cloned.isNotEmpty ? allPossibleCasesString(cloned) : [[]];
  //   for (var r in remainder) for (var h in first) yield [h, ...r];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Thuộc tính sản phẩm',
        leading: InkWell(
          child: _attributes.isNotEmpty ? Icon(Icons.check) : Icon(Icons.close),
          onTap: () => Navigator.pop(
              context,
              ProductPropertiesChangedParams(
                  attributes: _attributes, variants: _variants)),
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
        child: this._attributes.isEmpty
            ? Center(
                child: Text('Sản phẩm chưa có thuộc tính nào'),
              )
            : ListView.builder(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                itemCount: _variants.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      index == 0
                          ? PropertiesTable(
                              attributes: this._attributes,
                              onAttributeChanged: (values) {
                                setState(() => this._attributes = values);
                                _buildVariantsFromAttributes(
                                    values,
                                    ModalRoute.of(context).settings.arguments
                                        as ProductPropertiesDefault);
                              },
                            )
                          : Container(),
                      ProductPropertiesItem(
                        onChangeVariant: (variant) =>
                            setState(() => _variants[index] = variant),
                        variants: _variants[index],
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
