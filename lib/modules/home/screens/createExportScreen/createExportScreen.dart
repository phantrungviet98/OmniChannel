import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/modules/export/bloc/ExportBloc.dart';
import 'package:omnichannel_flutter/modules/export/bloc/ExportEvent.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportBloc.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportEvent.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportState.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/widget/PickedProduct.dart';
import 'package:omnichannel_flutter/modules/home/screens/createExportScreen/widget/normal_text_input.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseBloc.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseEvent.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseState.dart';
import 'package:omnichannel_flutter/modules/import/bloc/ImportEvent.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

enum CreateImportExportType { IMPORT, EXPORT }

class createExportScreen extends StatefulWidget {
  @override
  createExportScreenState createState() => createExportScreenState();
}

class createExportScreenState extends State<createExportScreen>
    with AfterLayoutMixin {
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController styleController = new TextEditingController();
  final picker = ImagePicker();

  @override
  void afterFirstLayout(BuildContext context) {
    final stockBloc = BlocProvider.of<StorehouseBloc>(context);
    final createBloc = BlocProvider.of<CreateImportExportBloc>(context);

    if (stockBloc.state.stocks.isNotEmpty) {
      createBloc.add(ChangeStock(stockBloc.state.stocks.first.id));
    } else {
      stockBloc.stream.listen((event) {
        if (event.status == Status.success) {
          createBloc.add(ChangeStock(stockBloc.state.stocks.first.id));
        }
      });
      stockBloc.add(StoreHouseEventGetStocks());
    }
  }

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // _showBottomSheet() {
  //   showModalBottomSheet(
  //       context: context,
  //       backgroundColor: Colors.transparent,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: MediaQuery.of(context).size.height * 0.3,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //                 topRight: Radius.circular(16), topLeft: Radius.circular(16)),
  //           ),
  //           child: Container(
  //             padding:
  //                 EdgeInsets.only(top: 50, bottom: 20, right: 30, left: 30),
  //             child: Column(
  //               children: [
  //                 InkWell(
  //                   onTap: () async {
  //                     final pickedFile =
  //                         await picker.getImage(source: ImageSource.camera);
  //
  //                     setState(() {
  //                       if (pickedFile != null) {
  //                         _image = File(pickedFile.path);
  //                         Navigator.pop(context);
  //                       } else {
  //                         print('No image selected.');
  //                       }
  //                     });
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(Radius.circular(10)),
  //                         color: Colors.grey.shade50),
  //                     padding: EdgeInsets.all(8),
  //                     child: Row(
  //                       children: [
  //                         Icon(
  //                           Icons.camera_alt,
  //                           size: 30,
  //                           color: Colors.black,
  //                         ),
  //                         SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           "Chụp ảnh từ Camera",
  //                           style: TextStyle(color: Colors.black, fontSize: 18),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 InkWell(
  //                   onTap: () async {
  //                     final pickedFile =
  //                         await picker.getImage(source: ImageSource.gallery);
  //
  //                     setState(() {
  //                       if (pickedFile != null) {
  //                         _image = File(pickedFile.path);
  //                         Navigator.pop(context);
  //                       } else {
  //                         print('No image selected.');
  //                       }
  //                     });
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(Radius.circular(10)),
  //                         color: Colors.grey.shade50),
  //                     padding: EdgeInsets.all(8),
  //                     child: Row(
  //                       children: [
  //                         Icon(
  //                           Icons.photo,
  //                           size: 30,
  //                           color: Colors.black,
  //                         ),
  //                         SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           "Chọn ảnh từ thư viện",
  //                           style: TextStyle(color: Colors.black, fontSize: 18),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  _createdCallback(bool success) {
    final type =
        ModalRoute.of(context).settings.arguments as CreateImportExportType;

    if (success) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
              'Tạo phiếu ${type == CreateImportExportType.IMPORT ? 'nhập kho' : 'xuất kho'} thành công'),
          content: Text('Chúc bạn mua may bán đắc nhé.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                BlocProvider.of<ExportBloc>(context).add(
                    type == CreateImportExportType.IMPORT
                        ? ImportEventPaging()
                        : ExportEventPaging());
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Có lỗi xãy ra!!'),
          content: const Text('Thử lại bạn nhé.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  _onPressSubmit() {
    final type =
        ModalRoute.of(context).settings.arguments as CreateImportExportType;
    FocusScope.of(context).requestFocus(FocusNode());
    BlocProvider.of<CreateImportExportBloc>(context).add(
        type == CreateImportExportType.IMPORT
            ? TriggerCreateImport(callback: _createdCallback)
            : TriggerCreateExport(callback: _createdCallback));
  }

  @override
  Widget build(BuildContext context) {
    final createBloc = BlocProvider.of<CreateImportExportBloc>(context);
    final type =
        ModalRoute.of(context).settings.arguments as CreateImportExportType;

    return Scaffold(
      appBar: CustomAppBar(
        title:
            'Tạo phiếu ${type == CreateImportExportType.IMPORT ? 'nhập' : 'xuất'} kho',
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
              BlocBuilder<StorehouseBloc, StorehouseState>(
                  builder: (context, stockState) => BlocBuilder<
                          CreateImportExportBloc, CreateImportExportState>(
                        builder: (context, state) {
                          log(state.payload.toString());

                          return DropdownButton(
                            isExpanded: true,
                            underline: Divider(
                                height: 0, thickness: 1.5, color: Colors.grey),
                            value: state.payload.stockId,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            items: stockState.stocks.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                value: item.id,
                              );
                            }).toList(),
                            onChanged: (id) {
                              createBloc.add(UpdatePayload(createBloc
                                  .state.payload
                                  .copyWith(stockId: id)));
                            },
                          );
                        },
                      )),
              SizedBox(
                height: 10,
              ),
              PickedProduct(),
              NormalTextInput(
                onChanged: (text) => createBloc.add(ChangeNote(text)),
                color: Colors.black,
                fontSize: 16,
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                hintText: ("Ghi chú"),
                hintTextFontSize: 14,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                minLines: 10,
                maxLines: 20,
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   "Chọn sản phẩm",
              //   style: TextStyle(color: Colors.grey),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // DropdownButton(
              //   isExpanded: true,
              //   underline:
              //       Divider(height: 0, thickness: 1.5, color: Colors.grey),
              //   value: _item,
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Colors.black,
              //   ),
              //   items: _listItem.map((item) {
              //     return DropdownMenuItem(
              //       child: Text(
              //         item,
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Colors.black,
              //         ),
              //       ),
              //       value: item,
              //     );
              //   }).toList(),
              //   onChanged: _onChangeItem,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // NormalTextInput(
              //   onChanged: (text) {
              //     setState(() {
              //       quantityErr = null;
              //     });
              //   },
              //   color: Colors.black,
              //   errorText: quantityErr,
              //   fontSize: 16,
              //   controller: quantityController,
              //   keyboardType: TextInputType.number,
              //   hintText: ("Nhập số lượng sản phẩm*"),
              //   hintTextFontSize: 14,
              //   contentPadding: EdgeInsets.symmetric(vertical: 10),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // NormalTextInput(
              //   onChanged: (text) {
              //     setState(() {
              //       styleErr = null;
              //     });
              //   },
              //   color: Colors.black,
              //   errorText: styleErr,
              //   fontSize: 16,
              //   controller: styleController,
              //   keyboardType: TextInputType.name,
              //   hintText: ("Mẫu mã*"),
              //   hintTextFontSize: 14,
              //   contentPadding: EdgeInsets.symmetric(vertical: 10),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       "Chụp ảnh sản phẩm",
              //       style: TextStyle(
              //         fontSize: 14,
              //       ),
              //     ),
              //     Spacer(),
              //     InkWell(
              //       onTap: () async {
              //         _showBottomSheet();
              //       },
              //       child: Icon(
              //         Icons.add_a_photo_outlined,
              //         size: 40,
              //         color: Colors.blueAccent,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.grey.shade300,
              //       borderRadius: BorderRadius.all(Radius.circular(16))),
              //   width: double.infinity,
              //   height: 300,
              //   child: _image != null
              //       ? ClipRRect(
              //           borderRadius: BorderRadius.all(Radius.circular(16)),
              //           child: Image.file(
              //             _image,
              //             fit: BoxFit.cover,
              //           ))
              //       : Icon(
              //           Icons.photo,
              //           size: 50,
              //         ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<CreateImportExportBloc,
                    CreateImportExportState>(
                  builder: (context, state) => AppButton(
                    title: 'Tạo phiếu',
                    onPressed: _onPressSubmit,
                    loading: state.isCreating,
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
