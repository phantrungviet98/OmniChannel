import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';

class ExpandItem extends StatelessWidget {
  const ExpandItem(
      {this.name = '',
      this.phoneNumber = '',
      this.address = '',
      this.city = '',
      this.code = '',
      this.cod = '',
      this.noteInternal = '',
      this.noteGuest = ''});

  final String name;
  final String phoneNumber;
  final String address;
  final String city;
  final String code;
  final String cod;
  final String noteInternal;
  final String noteGuest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                this.name,
                style: TextStyle(
                    color: AppColors.sage,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                'SĐT: ${this.phoneNumber}',
                style: TextStyle(
                    color: AppColors.sage,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Line(
            name: 'Địa chỉ',
            value: this.address,
          ),
          Line(
            name: 'Tỉnh/thành phố',
            value: this.city,
          ),
          Line(
            name: 'Mã vận đơn',
            value: this.code,
          ),
          Line(
            name: 'Phí vận chuyển',
            value: this.cod,
          ),
          Line(
            name: 'Ghi chú nội bộ',
            value: this.noteInternal,
          ),
          Line(
            name: 'Ghi chú khách',
            value: this.noteGuest,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Icon(Icons.edit),
              ),
              InkWell(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line({this.name, this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('$name: '), Text(value)],
      ),
    );
  }
}
