import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/data/modals/LookupProduct.dart';
import 'package:omnichannel_flutter/utis/ui/Shadow.dart';

class PickProductItem extends StatelessWidget {
  const PickProductItem({this.product, this.onTap});

  final LookupProductModal product;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        decoration: BoxDecoration(boxShadow: [Shadow.light], color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: TextStyle(color: AppColors.sage, fontSize: 20),),
            Row(
              children: [
                Text('Giá: '),
                Text(product.price.toString()),
              ],
            ),
            Text(product.attributes
                .map((e) => '${e.name}: ${e.value}')
                .toList()
                .join('; ')),
          ],
        ),
      ),
    );
  }
}
