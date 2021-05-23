import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shadow {
  static final primary = BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 5,
      offset: Offset(0, 1)
  );
}