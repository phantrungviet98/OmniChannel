import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:omnichannel_flutter/assets/json/JsonAnimates.dart';

class FullScreenLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(JsonAnimates.loadingCircles, height: 100),
    );
  }
}