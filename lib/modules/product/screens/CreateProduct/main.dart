import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductState.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/ImagePicker.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/MenWomenBoyGirlCheckBox.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/OneFieldLine.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/ProductCreateFormWrapper.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/ProductDescriptionInput.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/ProductProperties.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/SelectCategory.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/TagsPicker.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/TwoFieldLine.dart';
import 'package:omnichannel_flutter/utis/ui/main.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class CreateProductScreen extends BaseScreenStateful {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CreateProductScreen> {
  _openConfirmCloseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
            'Bạn có chắc chắn muốn thoát ?. Dữ liệu bạn đã nhập (nếu có) sẽ bị xóa.'),
        actions: [
          AppButton(
            title: 'Không',
            color: Colors.redAccent,
            onPressed: () => Navigator.pop(context),
          ),
          AppButton(
            title: 'Có',
            onPressed: () {
              BlocProvider.of<CreateProductBloc>(context).add(CreateProductEventClear());
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final createProductBloc = BlocProvider.of<CreateProductBloc>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Thêm sản phẩm',
        leading: BackButton(onPressed: () => _openConfirmCloseDialog(context)),
      ),
      body: BlocConsumer<CreateProductBloc, CreateProductState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Navigator.pop(context);
            createProductBloc.add(CreateProductEventClear());
            showSnackBar(context, text: 'Tạo sản phẩm thành công');
          }
        },
        builder: (context, state) {
          return Container(
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
                              onChange: (cate) => createProductBloc.add(
                                  CreateProductEventChangeCategory(cate: cate)),
                            ),
                            OneFieldLine(
                              hint: 'Tên sản phẩm',
                              onChanged: (text) => createProductBloc.add(
                                  CreateProductEventChangeName(name: text)),
                            ),
                            TwoFieldLine(
                              hint1: 'Giá bán',
                              hint2: 'Trọng lượng',
                              onChanged1: (text) => createProductBloc.add(
                                  CreateProductEventChangePrice(
                                      price: num.parse(text).toDouble())),
                              onChanged2: (text) => createProductBloc.add(
                                  CreateProductEventChangeWeight(
                                      weight: num.parse(text).toDouble())),
                            ),
                            TwoFieldLine(
                              hint1: 'Giá nhập',
                              hint2: 'Giá giảm',
                              onChanged1: (text) => createProductBloc.add(
                                  CreateProductEventChangeInPrice(
                                      inPrice: num.parse(text).toDouble())),
                              onChanged2: (text) => createProductBloc.add(
                                  CreateProductEventChangeSalePrice(
                                      salePrice: num.parse(text).toDouble())),
                            ),
                            OneFieldLine(
                              hint: 'Thương hiệu',
                              onChanged: (text) => createProductBloc.add(
                                  CreateProductEventChangeBranch(branch: text)),
                            ),
                            BlocBuilder<CreateProductBloc, CreateProductState>(
                              builder: (context, state) {
                                return TagsPicker(
                                  tags:
                                      state.createProductInput.tagNames != null
                                          ? state.createProductInput.tagNames
                                          : [],
                                  onSubmitted: (text) => createProductBloc
                                      .add(CreateProductEventAddTag(tag: text)),
                                  onRemoved: (index) {
                                    createProductBloc.add(
                                        CreateProductEventRemoveTag(
                                            index: index));
                                    return true;
                                  },
                                );
                              },
                            ),
                            BlocBuilder<CreateProductBloc, CreateProductState>(
                              builder: (context, state) {
                                return MenWomanBoyGirlCheckBox(
                                  isMen: state.createProductInput.men,
                                  isWomen: state.createProductInput.women,
                                  isBoy: state.createProductInput.boy,
                                  isGirl: state.createProductInput.girl,
                                  onChangeMen: (value) => createProductBloc.add(
                                      CreateProductEventChangeIsMen(
                                          isMen: value)),
                                  onChangeWomen: (value) => createProductBloc
                                      .add(CreateProductEventChangeIsWomen(
                                          isWomen: value)),
                                  onChangeBoy: (value) => createProductBloc.add(
                                      CreateProductEventChangeIsBoy(
                                          isBoy: value)),
                                  onChangeGirl: (value) => createProductBloc
                                      .add(CreateProductEventChangeIsGirl(
                                          isGirl: value)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CreateProductBloc, CreateProductState>(
                        builder: (context, state) {
                          return ProductCreateFormWrapper(
                            child: ImagePicker(
                              images: state.createProductInput.photoUrls,
                              onNewImagePickedAndUploaded: (url) {
                                createProductBloc
                                    .add(CreateProductEventAddPhotoUrls(url));
                              },
                              onPressRemove: (index) => createProductBloc.add(
                                  CreateProductEventRemovePhotoUrls(index)),
                            ),
                          );
                        },
                      ),
                      ProductCreateFormWrapper(
                        child: ProductDescriptionInput(
                          onChanged: (text) => createProductBloc.add(
                              CreateProductEventChangeDescription(des: text)),
                        ),
                      ),
                      ProductCreateFormWrapper(
                        child: ProductProperties(
                          onAttributeChange: (value) {
                            createProductBloc.add(
                                CreateProductEventChangeAttributes(
                                    attributes: value.attributes));
                            createProductBloc.add(
                                CreateProductEventChangeVariants(
                                    variants: value.variants));
                          },
                        ),
                      ),
                      AppButton(
                        title: 'Tạo Sản phẩm ngay',
                        color: AppColors.languidLavender,
                        onPressed: () =>
                            createProductBloc.add(CreateProductEventRequest()),
                        loading: state.status == Status.loading,
                      ),
                      Container(
                        height: 32,
                      )
                    ],
                  );
                }, childCount: 1))
              ],
            ),
          );
        },
      ),
    );
  }
}
