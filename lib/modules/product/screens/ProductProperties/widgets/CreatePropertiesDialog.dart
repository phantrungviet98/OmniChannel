import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/constant/Metrics.dart';
import 'package:omnichannel_flutter/data/modals/ManagementProductResponse.dart' as ProductModal;
import 'package:omnichannel_flutter/modules/product/screens/ProductProperties/widgets/ConfirmCloseDialog.dart';
import 'package:omnichannel_flutter/utis/ui/main.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';

class CreatePropertiesDialog extends StatefulWidget {
  const CreatePropertiesDialog({this.onDone});
  final Function(List<ProductModal.Attributes>) onDone;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CreatePropertiesDialog> {
  final _nameInputController = TextEditingController();
  final _valueInputController = TextEditingController();

  _openConfirmCloseDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return ConfirmCloseDialog();
    });
  }

  String _name = '';
  List<ProductModal.Attributes> _props = [];

  String _nameErrorText = '';
  String _valueErrorText = '';

  _onPressAddValue() {
    if (_valueInputController.text.isEmpty) {
      this.setState(() {
        _valueErrorText = 'Bạn cần phải nhập giá trị cho thuộc tính';
      });
    } else if (_props.any((element) =>
    element.value == _valueInputController.text)) {
      this.setState(() {
        _valueErrorText = 'Bạn cần nhập 1 giá trị khác';
      });
    } else {
      setState(() {
        _props.add(ProductModal.Attributes(
            name: _name,
            value: _valueInputController.text));
      });
      _valueInputController.text = '';
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(left: 16, right: 16),
      actions: [
        _name.isEmpty
            ? AppButton(
                title: 'Đóng',
                onPressed: () {
                  if (_name.isNotEmpty || _props.isNotEmpty) {
                    _openConfirmCloseDialog(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                color: Colors.redAccent,
              )
            : AppButton(
                title: 'Quay lại',
                onPressed: () {
                  this.setState(() {
                    _name = '';
                  });
                },
              ),
        AppButton(
          onPressed: () {
            if (_name.isEmpty) {
              setState(() {
                this.setState(() {
                  _nameErrorText = _nameInputController.text.isEmpty
                      ? 'Bạn cần phải nhập tên thuộc tính để tiếp tục'
                      : '';
                });
                if (_nameInputController.text.isNotEmpty) {
                  _name = _nameInputController.text;
                  if (_props.isNotEmpty) {
                    _props = _props
                        .map((e) => ProductModal.Attributes(
                            name: _nameInputController.text, value: e.value))
                        .toList();
                  }
                }
              });
            } else {
              if (_props.isEmpty) {
                setState(() {
                  _valueErrorText = 'Vui lòng nhập ít nhất 1 giá trị';
                });
              } else {
                widget.onDone(_props);
                Navigator.pop(context);
              }
            }
          },
          title: _name.isEmpty ? 'Tiếp theo' : 'Xong',
        ),
      ],
      content: SizedBox(
        height: _name.isEmpty ? 120 : 258,
        width: Metrics.getScreenWidth(context) * 0.9,
        child: Column(
          children: [
            Padding(
                child: Text(
                  'Tạo thuộc tính',
                  style: TextStyle(fontSize: 20),
                ),
                padding: EdgeInsets.only(bottom: 10)),
            _name.isEmpty
                ? TextFormField(
                    controller: _nameInputController,
                    onChanged: (text) {
                      if (_nameErrorText.isNotEmpty) {
                        this.setState(() => _nameErrorText = '');
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Size',
                        labelText: 'Tên thuộc tính',
                        errorText:
                            _nameErrorText.isNotEmpty ? _nameErrorText : null),
                    onFieldSubmitted: (String value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  )
                : Column(
                    children: [
                      Text(
                        _name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: _valueInputController,
                        decoration: InputDecoration(
                            hintText: 'S, M, L',
                            labelText: 'Giá trị',
                            errorText: _valueErrorText.isNotEmpty
                                ? _valueErrorText
                                : null),
                        onChanged: (text) {
                          if (_valueErrorText.isNotEmpty) {
                            setState(() {
                              this._valueErrorText = '';
                            });
                          }
                        },
                        onFieldSubmitted: (text) => _onPressAddValue(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(shape: CircleBorder()),
                          child: Icon(Icons.add, color: Colors.white),
                          onPressed: _onPressAddValue,
                        ),
                      ),
                      Tags(
                        itemCount: _props.length,
                        direction: Axis.horizontal,
                        horizontalScroll: true,
                        itemBuilder: (index) {
                          return ItemTags(
                            index: index,
                            title:
                                _props[index].name + ': ' + _props[index].value,
                            activeColor: AppColors.bone,
                            pressEnabled: false,
                            removeButton: ItemTagsRemoveButton(onRemoved: () {
                              this.setState(() => _props.removeAt(index));
                              return true;
                            }),
                          );
                        },
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
