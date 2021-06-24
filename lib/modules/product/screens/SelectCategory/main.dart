import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/Category/CategoryState.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateCate/CreateCateBloc.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateCate/CreateCateEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateCate/CreateCateState.dart';
import 'package:omnichannel_flutter/utis/sideEffect.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';
import 'package:omnichannel_flutter/widgets/FullScreenLoading/main.dart';

class SelectCategoryScreen extends BaseScreenStateful {
  @override
  State<StatefulWidget> createState() {
    return _SelectCategoryState();
  }
}

class _SelectCategoryState extends State<SelectCategoryScreen> {
  final _createNameController = TextEditingController();

  _openCreateCateForm(BuildContext context, CreateCateBloc createCateBloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: BlocConsumer<CreateCateBloc, CreateCateState>(
            bloc: createCateBloc,
            listener: (context, state) {
              if (state is CreateCateStateSuccess) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return (SizedBox(
                height: 146,
                child: Column(
                  children: [
                    Padding(
                        child: Text('Tạo danh mục'),
                        padding: EdgeInsets.only(bottom: 10)),
                    TextField(
                      decoration: InputDecoration(hintText: 'Tên danh mục'),
                      controller: _createNameController,
                    ),
                    Padding(
                        child: AppButton(
                          loading: state is CreateCateStateLoading,
                          onPressed: () {
                            createCateBloc.add(
                                CreateCateEvent(
                                    name: _createNameController.text));
                          },
                          title: 'Tạo',
                        ),
                        padding: EdgeInsets.only(top: 20))
                  ],
                ),
              ));
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cateBloc = CategoryBloc();
    final createCateBloc = CreateCateBloc(categoryBloc: cateBloc);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chọn danh mục sản phẩm',
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                _openCreateCateForm(context, createCateBloc);
              },
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => cateBloc),
            BlocProvider<CreateCateBloc>(
                create: (context) => createCateBloc),
          ],
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.allCate.status == Status.loading) {
                return FullScreenLoading();
              }
              if (state.allCate.status == Status.success) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Tìm kiếm'),
                        onChanged: (text) =>
                            BlocProvider.of<CategoryBloc>(context)
                                .add(CategoryEventSearch(searchText: text)),
                      ),
                    ),
                    Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async => cateBloc.add(CategoryEventGetAll()),
                          child: ListView.builder(
                            itemCount: state.allCate.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                // trailing: PopupMenuButton(
                                //   onSelected: (value) {
                                //     if (value == -1) {
                                //       // xóa
                                //     }
                                //   },
                                //   icon: Icon(Icons.more_vert),
                                //   itemBuilder: (context) => [
                                //     PopupMenuItem(
                                //       child: Text('Xóa'),
                                //       value: -1,
                                //     ),
                                //   ],
                                // ),
                                onTap: () {
                                  Navigator.pop(context, state.allCate.data[index]);
                                },
                                title: Text(state.allCate.data[index].name),
                              );
                            },
                          ),
                        ))
                  ],
                );
              }
              return Container(
                child: Text('Bạn chưa có danh mục nào'),
              );
            },
          )),
    );
  }
}
