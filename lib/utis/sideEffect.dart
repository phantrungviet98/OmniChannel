import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

executeContextBlock(FrameCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback(callback);
}