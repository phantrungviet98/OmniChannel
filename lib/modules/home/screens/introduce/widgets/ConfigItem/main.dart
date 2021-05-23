import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/fonts/FontSize.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';

class ConfigItem extends StatelessWidget {
  final Widget logo;
  final String title;
  final String description;
  final String buttonText;
  final Function onPressed;

  ConfigItem(
      {this.logo,
      this.title,
      this.description,
      this.buttonText,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 16, right: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 7,
                spreadRadius: 0.5,
                color: AppColors.languidLavender),
          ],
          color: Colors.white),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Padding(padding: EdgeInsets.only(right: 10), child: logo)),
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: FontSize.big),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      description,
                      style: TextStyle(fontSize: FontSize.small),
                    ),
                  ),
                  AppButton(
                    title: buttonText,
                    onPressed: onPressed,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
