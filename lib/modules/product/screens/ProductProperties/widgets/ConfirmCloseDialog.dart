import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';

class ConfirmCloseDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Text('Dữ liệu chưa được lưu.\nBạn có chắc chắn đóng ? '),
        actions: [
          AppButton(
            title: 'Quay lại',
            onPressed: () => Navigator.pop(context),
          ),
          AppButton(
            title: 'Đóng',
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: Colors.redAccent,
          )
        ]);
  }
}
