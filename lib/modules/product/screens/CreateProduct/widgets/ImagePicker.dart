import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as ImagePickerLib;
import 'package:http/http.dart' as http;
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/utis/ui/main.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker(
      {this.images, this.onNewImagePickedAndUploaded, this.onPressRemove});

  final List<String> images;
  final Function(String) onNewImagePickedAndUploaded;
  final Function(int) onPressRemove;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ImagePicker> {
  final picker = ImagePickerLib.ImagePicker();
  bool loading = false;

  Future getImage(BuildContext context) async {
    final pickedFile =
        await picker.getImage(source: ImagePickerLib.ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        loading = true;
      });
      final imageUrl = await uploadImage(File(pickedFile.path));
      setState(() {
        loading = false;
      });

      log('imageUrl' + imageUrl);

      widget.onNewImagePickedAndUploaded(imageUrl);
    } else {
      showSnackBar(context, text: 'Có lỗi xảy ra khi lưu trữ ảnh');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                getImage(context);
              },
              icon: !loading
                  ? Icon(
                      Icons.camera,
                      color: Colors.white,
                    )
                  : SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
              label: Text(
                'Chọn hình ảnh',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 400,
          child: widget.images.isNotEmpty
              ? GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 5,
                  children: List.generate(
                      widget.images.length,
                      (index) => Container(
                            decoration: BoxDecoration(
                              color: AppColors.silverMetallic,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    widget.images[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        iconSize: 30,
                                        onPressed: () =>
                                            widget.onPressRemove(index),
                                        padding: EdgeInsets.all(0),
                                        enableFeedback: true,
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          )),
                )
              : Center(
                  child: Text('Chưa có ảnh nào được chọn'),
                ),
        )
      ],
    );
  }
}

Future<String> uploadImage(File _image) async {
  final uri = Uri.parse("https://static-server1.bluebird.vn/upload.php");
  final request = new http.MultipartRequest("POST", uri)
    ..fields['filename'] = 'imagename'
    ..files.add(await http.MultipartFile.fromPath('file', _image.path));
  try {
    final response = await request.send();
    final json = await response.stream.bytesToString();
    return jsonDecode(json)['url'];
  } catch (e) {
    log(e.toString());
    return '';
  }
}
