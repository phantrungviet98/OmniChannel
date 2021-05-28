import 'package:flutter/cupertino.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class CreateCateEvent extends ProductEvent {
  const CreateCateEvent({@required this.name});
  final String name;
}