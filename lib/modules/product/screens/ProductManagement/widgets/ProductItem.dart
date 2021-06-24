import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnichannel_flutter/utis/ui/Shadow.dart';

const defaultPhoto = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYMZt8DcAt94DmfTzFV7BGzcm3FLFr3XqnY4-0hKSC9h1n11jFKp-Nqo59cjKXLS8V8qY&usqp=CAU';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {@required this.id,
        @required this.sId,
      @required this.photo,
      @required this.name,
      @required this.price,
      @required this.total,
      @required this.dateCreated});

  final int id;
  final String sId;
  final String photo;
  final String name;
  final double price;
  final int total;
  final int dateCreated;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/create-product', arguments: sId),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [Shadow.light],
        ),
        margin: EdgeInsets.only(left: 8, right: 4, bottom: 8),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                this.photo.isNotEmpty
                    ? this.photo
                    : defaultPhoto,
                height: 100,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                'Code: ' + this.id.toString(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                this.name,
                maxLines: 2,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Giá: ' + this.price.toString()),
                    Text('Kho: ' + this.total.toString()),
                    Text('Ngày tạo: ' +
                        DateFormat('dd-MM-yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(this.dateCreated))),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
