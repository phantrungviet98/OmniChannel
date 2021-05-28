import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/ImagePicker.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/MenWomenBoyGirlCheckBox.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/OneFieldLine.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/ProductCreateFormWrapper.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/ProductDescriptionInput.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/ProductProperties.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/SelectCategory.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/TagsPicker.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/TwoFieldLine.dart';
import 'package:omnichannel_flutter/utis/ui/Shadow.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class CreateProductScreen extends BaseScreenStateful {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CreateProductScreen> {
  Cats _cate;
  String _name;
  double _sellPrice;
  double _weight;
  double _buyPrice;
  double _discountPrice;
  String _brandName;
  List<String> _tags = [];
  bool _isMen = false;
  bool _isWomen = false;
  bool _isBoy = false;
  bool _isGirl = false;
  List<String> _photoUrls = [];
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Thêm sản phẩm'),
      body: Container(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  ProductCreateFormWrapper(
                    child: Column(
                      children: [
                        SelectCategory(
                          onChange: (cate) => _cate = cate,
                        ),
                        OneFieldLine(
                          hint: 'Tên sản phẩm',
                          onChanged: (text) => _name = text,
                        ),
                        TwoFieldLine(
                          hint1: 'Giá bán',
                          hint2: 'Trọng lượng',
                          onChanged1: (text) =>
                              _sellPrice = num.parse(text).toDouble(),
                          onChanged2: (text) =>
                              _weight = num.parse(text).toDouble(),
                        ),
                        TwoFieldLine(
                          hint1: 'Giá nhập',
                          hint2: 'Giá giảm',
                          onChanged1: (text) =>
                              _buyPrice = num.parse(text).toDouble(),
                          onChanged2: (text) =>
                              _discountPrice = num.parse(text).toDouble(),
                        ),
                        OneFieldLine(
                          hint: 'Thương hiệu',
                          onChanged: (text) => _brandName = text,
                        ),
                        TagsPicker(
                          tags: _tags,
                          onSubmitted: (text) {
                            setState(() {
                              _tags.add(text);
                            });
                          },
                          onRemoved: (index) {
                            setState(() {
                              _tags.removeAt(index);
                            });
                            return true;
                          },
                        ),
                        MenWomanBoyGirlCheckBox(
                          isMen: _isMen,
                          isWomen: _isWomen,
                          isBoy: _isBoy,
                          isGirl: _isGirl,
                          onChangeMen: (value) {
                            this.setState(() {
                              _isMen = value;
                            });
                          },
                          onChangeWomen: (value) {
                            this.setState(() {
                              _isWomen = value;
                            });
                          },
                          onChangeBoy: (value) {
                            this.setState(() {
                              this._isBoy = value;
                            });
                          },
                          onChangeGirl: (value) {
                            this.setState(() {
                              this._isGirl = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ProductCreateFormWrapper(
                    child: ImagePicker(
                      images: _photoUrls,
                      onNewImagePickedAndUploaded: (url) =>
                          this.setState(() {
                            _photoUrls.add(url);
                          }),
                      onPressRemove: (index) => this.setState(() {
                        _photoUrls.removeAt(index);
                      }),
                    ),
                  ),
                  ProductCreateFormWrapper(
                    child: ProductDescriptionInput(onChanged: (text) {
                      _description = text;
                    },),
                  ),
                  ProductCreateFormWrapper(
                    child: ProductProperties(),
                  ),
                ],
              );
            }, childCount: 1))
          ],
        ),
      ),
    );
  }
}
