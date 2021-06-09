
import 'package:flutter/cupertino.dart';

class StorehouseItem extends StatelessWidget {
  const StorehouseItem({this.icon, this.label, this.labelStyle});

  final Widget icon;
  final String label;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Row(
          children: [
            icon ?? Container(),
            Flexible(
                child: Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                label,
                style: labelStyle,
              ),
            )),
          ],
        ));
  }
}
