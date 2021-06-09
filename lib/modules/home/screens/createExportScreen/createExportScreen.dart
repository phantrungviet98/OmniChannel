import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/widget/normal_text_input.dart';

class createExportScreen extends StatefulWidget {
  @override
  createExportScreenState createState() => createExportScreenState();
}

class createExportScreenState extends State<createExportScreen> {
  List<String> _listWareHouse = ["Kho 1", "Kho 2", "Kho 3"];
  List<String> _listItem = ["Mũ", "Áo sơ mi", "Giày", "Quần"];
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController styleController = new TextEditingController();
  String errText = null;
  String quantityErr = null;
  String styleErr = null;
  String _wareHouse = "";
  String _item = "";
  File _image;
  final picker = ImagePicker();

  void initState() {
    super.initState();
    _wareHouse = _listWareHouse[0];
    _item = _listItem[0];
  }

  _onChangeWareHouse(String value) {
    setState(() {
      _wareHouse = value;
    });
  }

  _onChangeItem(String value) {
    setState(() {
      _item = value;
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  ///chỗ này sẽ gọi API up data lên
  _onPressSubmit() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (descriptionController.text.length == 0) {
      setState(() {
        errText = "Không được để trống thông tin";
      });
    }
    if (quantityController.text.length == 0) {
      setState(() {
        quantityErr = "Không được để trống thông tin";
      });
    }
    if (styleController.text.length == 0) {
      setState(() {
        styleErr = "Không được để trống thông tin";
      });
    }
    if (errText == null && quantityErr == null && styleErr == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Tạo phiếu xuất kho thành công'),
          content: const Text('Đoạn này build thử nên dùng mấy cái normal nhất nhé'),
          actions: <Widget>[
            TextButton(
              onPressed:(){
                Navigator.pop(context);
                Navigator.pop(context,true);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Tạo phiếu xuất kho"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chọn kho xuất hàng",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButton(
                isExpanded: true,
                underline: Divider(height: 0, thickness: 1.5, color: Colors.grey),
                value: _wareHouse,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                items: _listWareHouse.map((item) {
                  return DropdownMenuItem(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    value: item,
                  );
                }).toList(),
                onChanged: _onChangeWareHouse,
              ),
              SizedBox(
                height: 10,
              ),
              NormalTextInput(
                onChanged: (text) {
                  setState(() {
                    errText = null;
                  });
                },
                color: Colors.black,
                errorText: errText,
                fontSize: 16,
                controller: descriptionController,
                keyboardType: TextInputType.name,
                hintText: ("Nhập thông tin đơn hàng*"),
                hintTextFontSize: 14,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Chọn sản phẩm",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButton(
                isExpanded: true,
                underline: Divider(height: 0, thickness: 1.5, color: Colors.grey),
                value: _item,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                items: _listItem.map((item) {
                  return DropdownMenuItem(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    value: item,
                  );
                }).toList(),
                onChanged: _onChangeItem,
              ),
              SizedBox(
                height: 10,
              ),
              NormalTextInput(
                onChanged: (text) {
                  setState(() {
                    quantityErr = null;
                  });
                },
                color: Colors.black,
                errorText: quantityErr,
                fontSize: 16,
                controller: quantityController,
                keyboardType: TextInputType.number,
                hintText: ("Nhập số lượng sản phẩm*"),
                hintTextFontSize: 14,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              SizedBox(
                height: 10,
              ),
              NormalTextInput(
                onChanged: (text) {
                  setState(() {
                    styleErr = null;
                  });
                },
                color: Colors.black,
                errorText: styleErr,
                fontSize: 16,
                controller: styleController,
                keyboardType: TextInputType.name,
                hintText: ("Mẫu mã*"),
                hintTextFontSize: 14,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Chụp ảnh sản phẩm",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      final pickedFile = await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                        } else {
                          print('No image selected.');
                        }
                      });
                    },
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration:
                    BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.all(Radius.circular(16))),
                width: double.infinity,
                height: 300,
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ))
                    : Icon(
                        Icons.photo,
                        size: 50,
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: _onPressSubmit,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [],
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: Text(
                      "Giới thiệu",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
