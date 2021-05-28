import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/constant/Metrics.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class ProductDescriptionScreenParams {
  ProductDescriptionScreenParams({this.text});
  final String text;
}

class ProductDescription extends BaseScreenStateful {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductDescription> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context).settings.arguments as ProductDescriptionScreenParams;

    return Scaffold(
      appBar: CustomAppBar(
        leading: InkWell(child: Icon(Icons.close), onTap: () => Navigator.pop(context, _controller.text),),
        title: 'Mô tả sản phẩm',
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return TextField(
                        autofocus: true,
                        controller: _controller..text = params.text,
                        decoration: InputDecoration(
                            labelText: 'Mô tả',
                            hintText: "Nhập vào mô tả sản phẩm",
                            alignLabelWithHint: true,
                        ),
                        scrollPadding: EdgeInsets.all(20.0),
                        keyboardType: TextInputType.multiline,
                        maxLines: 25,
                      );
                    }, childCount: 1))
              ],
            ),
          ),
          AnimatedPositioned(child: AppButton(title: 'Xong', onPressed: () {
            Navigator.pop(context, _controller.text);
          },), duration: Duration(seconds: 2), bottom: 30, right: 16,)
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
