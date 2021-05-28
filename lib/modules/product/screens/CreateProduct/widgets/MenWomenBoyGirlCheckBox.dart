import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenWomanBoyGirlCheckBox extends StatelessWidget {
  const MenWomanBoyGirlCheckBox(
      {this.isMen,
      this.isWomen,
      this.isBoy,
      this.isGirl,
      this.onChangeMen,
      this.onChangeWomen,
      this.onChangeBoy,
      this.onChangeGirl});

  final bool isMen;
  final bool isWomen;
  final bool isBoy;
  final bool isGirl;
  final Function(bool) onChangeMen;
  final Function(bool) onChangeWomen;
  final Function(bool) onChangeBoy;
  final Function(bool) onChangeGirl;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CheckBoxWithText(text: 'Nam', value: isMen, onChanged: onChangeMen,),
          CheckBoxWithText(text: 'Nữ', value: isWomen, onChanged: onChangeWomen,),
          CheckBoxWithText(text: 'Bé trai', value: isBoy, onChanged: onChangeBoy,),
          CheckBoxWithText(text: 'Bé gái', value: isGirl, onChanged: onChangeGirl,),
        ],
      ),
    );
  }
}

class CheckBoxWithText extends StatelessWidget {
  const CheckBoxWithText({this.text, this.value, this.onChanged});
  final String text;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Checkbox(value: value, onChanged: onChanged),
          width: 36,
        ),
        Text(text)
      ],
    );
  }
}
