import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chi tiết sản phẩm'),
    );
  }
}