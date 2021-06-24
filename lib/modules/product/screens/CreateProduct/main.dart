import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
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
import 'package:omnichannel_flutter/widgets/FullScreenLoading/main.dart';

class CreateProductScreen extends BaseScreenStateful {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CreateProductScreen>
    with AfterLayoutMixin<CreateProductScreen> {
  @override
  void afterFirstLayout(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    if (id != null) {
      BlocProvider.of<CreateProductBloc>(context).add(GetProductDetail(id));
    }
  }

  Future<bool> _openConfirmCloseDialog(BuildContext context) async {
    final id = ModalRoute.of(context).settings.arguments as String;
    if (id != null) {
      return true;
    }

    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
            'Bạn có chắc chắn muốn thoát ?. Dữ liệu bạn đã nhập (nếu có) sẽ bị xóa.'),
        actions: [
          AppButton(
            title: 'Không',
            color: Colors.redAccent,
            onPressed: () => Navigator.pop(context, false),
          ),
          AppButton(
            title: 'Có',
            onPressed: () {
              BlocProvider.of<CreateProductBloc>(context)
                  .add(CreateProductEventClear());
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final createProductBloc = BlocProvider.of<CreateProductBloc>(context);
    final id = ModalRoute.of(context).settings.arguments as String;

    return WillPopScope(
      onWillPop: () async => await _openConfirmCloseDialog(context),
      child: Scaffold(
        appBar: CustomAppBar(
          title: id == null ? 'Thêm sản phẩm' : 'Cập nhật sản phẩm',
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
            if (state.productDetail?.status == Status.loading) {
              return FullScreenLoading();
            }
            return Container(
              child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Column(
                      children: [
                        ProductCreateFormWrapper(
                          child: Column(
                            children: [
                              SelectCategory(),
                              OneFieldLine(
                                hint: 'Tên sản phẩm',
                                initialValue: state.createProductInput.name,
                                onChanged: (text) => createProductBloc.add(
                                    CreateProductEventChangeName(name: text)),
                              ),
                              TwoFieldLine(
                                hint1: 'Giá bán',
                                hint2: 'Trọng lượng',
                                initialValue1: state.createProductInput.price?.toString(),
                                initialValue2: state.createProductInput.weight?.toString(),
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
                                initialValue1: state.createProductInput.inPrice?.toString(),
                                initialValue2: state.createProductInput.salePrice?.toString(),
                                onChanged1: (text) => createProductBloc.add(
                                    CreateProductEventChangeInPrice(
                                        inPrice: num.parse(text).toDouble())),
                                onChanged2: (text) => createProductBloc.add(
                                    CreateProductEventChangeSalePrice(
                                        salePrice: num.parse(text).toDouble())),
                              ),
                              OneFieldLine(
                                hint: 'Thương hiệu',
                                initialValue: state.createProductInput.brandName,
                                onChanged: (text) => createProductBloc.add(
                                    CreateProductEventChangeBranch(
                                        branch: text)),
                              ),
                              BlocBuilder<CreateProductBloc,
                                  CreateProductState>(
                                builder: (context, state) {
                                  return TagsPicker(
                                    tags: state.createProductInput.tagNames !=
                                            null
                                        ? state.createProductInput.tagNames
                                        : [],
                                    onSubmitted: (text) => createProductBloc
                                        .add(CreateProductEventAddTag(
                                            tag: text)),
                                    onRemoved: (index) {
                                      createProductBloc.add(
                                          CreateProductEventRemoveTag(
                                              index: index));
                                      return true;
                                    },
                                  );
                                },
                              ),
                              BlocBuilder<CreateProductBloc,
                                  CreateProductState>(
                                builder: (context, state) {
                                  return MenWomanBoyGirlCheckBox(
                                    isMen: state.createProductInput.men,
                                    isWomen: state.createProductInput.women,
                                    isBoy: state.createProductInput.boy,
                                    isGirl: state.createProductInput.girl,
                                    onChangeMen: (value) => createProductBloc
                                        .add(CreateProductEventChangeIsMen(
                                            isMen: value)),
                                    onChangeWomen: (value) => createProductBloc
                                        .add(CreateProductEventChangeIsWomen(
                                            isWomen: value)),
                                    onChangeBoy: (value) => createProductBloc
                                        .add(CreateProductEventChangeIsBoy(
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
                          title:
                              '${id == null ? 'Tạo' : 'Cập nhật'} Sản phẩm ngay',
                          color: AppColors.languidLavender,
                          onPressed: () => createProductBloc.add(id == null
                              ? CreateProductEventRequest()
                              : UpdateProductRequest(id, callback: (success) {
                                  showSnackBar(context,
                                      text:
                                          'Cập nhật sản phẩm ${success ? 'thành công' : 'thất bại'}');
                                })),
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
      ),
    );
  }
}
