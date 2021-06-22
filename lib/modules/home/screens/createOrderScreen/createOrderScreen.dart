import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/widget/normal_text_input.dart';

class createOrderScreen extends StatefulWidget {
  @override
  createOrderScreenState createState() => createOrderScreenState();
}

class createOrderScreenState extends State<createOrderScreen> {
  List<String> _listStyleSell = ["Bán tại cửa hàng", "Giao hàng thu hộ", "Giao hàng ứng tiền"];
  List<String> _listStyleShip = ["Người mua nhận hàng", "Giao hàng cho người khác"];
  List<String> _listWareHouse = ["Kho 1", "Kho 2", "Kho 3"];
  List<String> _listItem = ["Mũ", "Áo sơ mi", "Giày", "Quần"];
  TextEditingController discountController = new TextEditingController();
  TextEditingController firstPayController = new TextEditingController();
  TextEditingController styleController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _receverNumber = new TextEditingController();
  TextEditingController _receverName = new TextEditingController();
  TextEditingController _placeController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController _ = new TextEditingController();
  String errPhone = null;
  String errName = null;
  String errText = null;
  String quantityErr = null;
  String styleErr = null;
  String errNameRecever = null;
  String errPhoneRecever = null;
  String _wareHouse = "";
  String _styleSell = "";
  String _item = "";
  String _styleShip = "";
  File _image;

  ///sẽ có một trường giá khi cọn sản phẩm cái này ghép API các bạn xử lý nhé mình fix tạm giá ntn

  int price = 3000000;
  final picker = ImagePicker();

  void initState() {
    super.initState();
    _wareHouse = _listWareHouse[0];
    _item = _listItem[0];
    _styleSell = _listStyleSell[0];
    _styleShip = _listStyleShip[0];
    quantityController.text = 1.toString();
  }

  _onChangeWareHouse(String value) {
    setState(() {
      _wareHouse = value;
    });
  }

  _onChangeStyleSell(String value) {
    setState(() {
      _styleSell = value;
    });
  }

  _onChangeStyleShip(String value) {
    setState(() {
      _styleShip = value;
    });
  }

  _onChangeItem(String value) {
    setState(() {
      _item = value;
      quantityController.text = 1.toString();
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

  Widget infoCustomer() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn hình thức nhận hàng",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 5,
          ),
          DropdownButton(
            isExpanded: true,
            underline: Divider(height: 0, thickness: 1.5, color: Colors.grey),
            value: _styleShip,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            items: _listStyleShip.map((item) {
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
            onChanged: _onChangeStyleShip,
          ),
          SizedBox(
            height: 10,
          ),
          (_styleShip != _listStyleShip[0])
              ? Column(
                  children: [
                    NormalTextInput(
                      onChanged: (text) {
                        setState(() {
                          errPhoneRecever = null;
                        });
                      },
                      color: Colors.black,
                      errorText: errPhoneRecever,
                      fontSize: 16,
                      controller: _receverNumber,
                      keyboardType: TextInputType.number,
                      hintText: ("Số điện thoại người nhận *"),
                      hintTextFontSize: 14,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    NormalTextInput(
                      onChanged: (text) {
                        setState(() {
                          errNameRecever = null;
                        });
                      },
                      color: Colors.black,
                      errorText: errNameRecever,
                      fontSize: 16,
                      controller: _receverName,
                      keyboardType: TextInputType.name,
                      hintText: ("Tên người nhận *"),
                      hintTextFontSize: 14,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : SizedBox.shrink(),
          NormalTextInput(
            onChanged: (text) {
              setState(() {
                errNameRecever = null;
              });
            },
            color: Colors.black,
            errorText: errNameRecever,
            fontSize: 16,
            controller: _placeController,
            keyboardType: TextInputType.name,
            hintText: ("Địa chỉ"),
            hintTextFontSize: 14,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 50, bottom: 20, right: 30, left: 30),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final pickedFile = await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                          Navigator.pop(context);
                        } else {
                          print('No image selected.');
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey.shade50),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Chụp ảnh từ Camera",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      final pickedFile = await picker.getImage(source: ImageSource.gallery);

                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                          Navigator.pop(context);
                        } else {
                          print('No image selected.');
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey.shade50),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo,
                            size: 30,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Chọn ảnh từ thư viện",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  ///chỗ này sẽ gọi API up data lên
  _onPressSubmit() {
    FocusScope.of(context).requestFocus(FocusNode());
    var discount = int.parse(discountController.text);
    assert(discount is int);
    var firstPay = int.parse(firstPayController.text);
    assert(firstPay is int);
    var lastPrice = price - discount - firstPay;

    ///chỗ này các bạn tự validate nhé
    Dialog dialog = Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 200,
        height: 300,
        child: Column(
          children: [
            Text(
              "Có phải bạn muốn tạo đơn hàng sản phẩm ${_item.toString()} với giá ${lastPrice.toString()} đ",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Tạo đơn hàng"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chọn hình thức mua hàng",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButton(
                isExpanded: true,
                underline: Divider(height: 0, thickness: 1.5, color: Colors.grey),
                value: _styleSell,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                items: _listStyleSell.map((item) {
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
                onChanged: _onChangeStyleSell,
              ),
              SizedBox(
                height: 10,
              ),
              NormalTextInput(
                onChanged: (text) {
                  setState(() {
                    errPhone = null;
                  });
                },
                color: Colors.black,
                errorText: errPhone,
                fontSize: 16,
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                hintText: ("Số điện thoại khách hàng *"),
                hintTextFontSize: 14,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              SizedBox(
                height: 10,
              ),
              NormalTextInput(
                onChanged: (text) {
                  setState(() {
                    errName = null;
                  });
                },
                color: Colors.black,
                errorText: errName,
                fontSize: 16,
                controller: _nameController,
                keyboardType: TextInputType.name,
                hintText: ("Tên khách hàng *"),
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
              (_styleSell != _listStyleSell[0]) ? infoCustomer() : SizedBox.shrink(),
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
                controller: quantityController,
                keyboardType: TextInputType.number,
                hintText: ("Số lượng"),
                hintTextFontSize: 14,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
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
                controller: discountController,
                keyboardType: TextInputType.number,
                hintText: ("Giảm giá"),
                hintTextFontSize: 14,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
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
                controller: firstPayController,
                keyboardType: TextInputType.number,
                hintText: ("Đã thanh toán trước"),
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
                      _showBottomSheet();
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
                      "Xác nhận",
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
