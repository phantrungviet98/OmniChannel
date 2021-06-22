import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportBloc.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportEvent.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportState.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/widget/PickProductDialog.dart';
import 'package:omnichannel_flutter/utis/ui/Shadow.dart';

class PickedProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<PickedProduct> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animationController.repeat();

    return DecoratedBox(
      decoration: BoxDecoration(
          boxShadow: [Shadow.light],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _buildRowHeader(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child:
                  BlocBuilder<CreateImportExportBloc, CreateImportExportState>(
                builder: (context, state) {
                  return PageView(
                    controller: controller,
                    children: <Widget>[
                      ...List.from(state.payload.items.asMap().entries.map(
                          (e) => _buildRowData(
                              e.value.productName, '', e.value.qty.toString(),
                              onPressMinus: () =>
                                  BlocProvider.of<CreateImportExportBloc>(context)
                                      .add(MinusQuantity(index: e.key)),
                              onPressAdd: () =>
                                  BlocProvider.of<CreateImportExportBloc>(
                                          context)
                                      .add(AddQuantity(index: e.key))))),
                      Center(
                        child: InkWell(
                          onTap: _pickProductDialog,
                          child: AnimatedIcon(
                            icon: AnimatedIcons.add_event,
                            progress: _animationController,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _pickProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return PickProductDialog();
      },
    );
  }

  _buildRowData(String productName, String type, String qty,
      {Function onPressMinus, Function onPressAdd}) {
    return Row(
      children: [
        Expanded(child: Text(productName)),
        Expanded(child: Text(type)),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: onPressMinus,
                child: Icon(Icons.remove),
              ),
              Text(qty),
              InkWell(
                onTap: onPressAdd,
                child: Icon(Icons.add),
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildRowHeader() {
    return Row(
      children: [
        Expanded(
            child: Text(
          'Tên sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        Expanded(
            child: Text(
          'Mẫu mã',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        Expanded(
          child: Text(
            'Số lượng',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
