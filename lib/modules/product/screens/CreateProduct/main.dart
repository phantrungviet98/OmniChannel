import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/utis/ui/Shadow.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class CreateProductScreen extends BaseScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Thêm sản phẩm'),
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/select-category');
                            },
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Chọn danh mục',
                                  hintStyle:
                                      TextStyle(color: Colors.black)),
                              enabled: false,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: 'Tên sản phẩm'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Giá bán'),
                                      ),
                                      padding: EdgeInsets.only(right: 4)),
                                ),
                                Expanded(
                                  child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Trọng lượng'),
                                      ),
                                      padding: EdgeInsets.only(right: 4)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Giá nhập'),
                                      ),
                                      padding: EdgeInsets.only(right: 4)),
                                ),
                                Expanded(
                                  child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Giá giảm'),
                                      ),
                                      padding: EdgeInsets.only(right: 4)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [Shadow.primary],
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                ],
              );
            }, childCount: 1))
          ],
        ),
      ),
    );
  }
}
