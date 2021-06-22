import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';


class NormalTextInput extends StatefulWidget {
  final double fontSize; // cỡ chữ
  final Color color; // màu chữ
  final String errorText; // nội dung lỗi (null: ẩn)
  final double errorFontSize; // cỡ chữ lỗi
  final Color errorColor; // màu chữ lỗi
  final Color focusColor; // màu dòng gạch chân khi focus
  final String fontFamily; // font chữ
  final FloatingLabelBehavior floatingLabelBehavior; // floating label hay không
  final String hintText; // nội dung label
  final double hintTextFontSize; // kích thước label (khi chưa floating)
  final String hintTextFontFamily; // font chữ label
  final Widget suffix; // widget sau (mặc định là nút clear)
  final Widget prefixIcon; // widget trước
  final BoxConstraints prefixIconConstraints; //
  final TextEditingController controller; // controller (bắt buộc phải có)
  final int maxLength; //
  final bool showMaxLengthCount; // hiện bộ đếm của maxLength
  final TextInputType keyboardType; //
  final bool obscureText; // ân text (vd: mật khẩu)
  final FocusNode focusNode; //
  final bool autoFocus; //
  final Function onChanged; //
  final EdgeInsetsGeometry contentPadding; //
  final bool hideUnderBorderLine; // ẩn hiện gạch chân
  final Widget imageClear; // widget thay cho nút clear mặc định
  final ThemeData themeData; // dùng để thay đổi Theme (vd: màu chữ label khi floating)
  final Brightness keyboardAppearance;
  final bool readOnly;
  final int minLines;
  final int maxLines;

  const NormalTextInput({
    this.fontSize,
    this.errorText,
    this.errorFontSize,
    this.fontFamily,
    this.color,
    this.focusColor,
    this.errorColor,
    this.floatingLabelBehavior,
    this.hintText,
    this.hintTextFontSize,
    this.hintTextFontFamily,
    this.suffix,
    this.prefixIcon,
    this.prefixIconConstraints,
    @required this.controller,
    this.maxLength,
    this.showMaxLengthCount,
    this.keyboardType,
    this.obscureText,
    this.focusNode,
    this.onChanged,
    this.contentPadding,
    this.hideUnderBorderLine,
    this.imageClear,
    this.themeData,
    this.autoFocus,
    this.keyboardAppearance,
    this.readOnly,
    this.minLines,
    this.maxLines,
  });

  @override
  State<StatefulWidget> createState() {
    return _NormalTextInputState();
  }
}

class _NormalTextInputState extends State<NormalTextInput> {
  void onChanged(String text) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.themeData ??
          ThemeData(
            primaryColor: AppColors.sage,
            hintColor: Colors.grey,
          ),
      child: TextField(
        readOnly: widget.readOnly ?? false,
        style: TextStyle(
            fontSize: widget.fontSize ?? 18,
            color: widget.color ?? Colors.black,
            fontFamily: widget.fontFamily ),
        decoration: InputDecoration(
            contentPadding: widget.contentPadding,
            floatingLabelBehavior: widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
            labelText: widget.hintText,
            labelStyle: TextStyle(
              fontSize: widget.hintTextFontSize ?? 15,
              fontFamily: widget.hintTextFontFamily,
            ),
            errorText: widget.errorText,
            errorStyle: TextStyle(fontSize: widget.errorFontSize ?? 14, color: widget.errorColor ?? Colors.red),

            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: widget.prefixIconConstraints,
            counter: widget.showMaxLengthCount == true
                ? null
                : SizedBox(
              height: 0.0,
            ),
            focusedBorder: widget.hideUnderBorderLine == true
                ? UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.1))
                : UnderlineInputBorder(
                borderSide: BorderSide(color: widget.focusColor ?? AppColors.sage, width: 2)),
            enabledBorder: widget.hideUnderBorderLine == true
                ? UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.1))
                : UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1))),
        controller: widget.controller,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged ?? onChanged,
        autofocus: widget.autoFocus ?? false,
        keyboardAppearance: widget.keyboardAppearance ?? Brightness.light,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
      ),
    );
  }
}
