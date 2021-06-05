import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductBloc.dart';
import 'package:omnichannel_flutter/modules/product/screens/CreateProduct/widgets/OneFieldLine.dart';

class TagsPicker extends StatelessWidget {
  const TagsPicker({this.onSubmitted, this.onRemoved, this.tags});

  final OnSubmittedCallback onSubmitted;
  final bool Function(int) onRemoved;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    log(BlocProvider.of<CreateProductBloc>(context).state.createProductInput.toString());
    return Column(
      children: [
        OneFieldLine(
          hint: 'Tags',
          onSubmitted: onSubmitted,
          isClearOnSubmit: true,
        ),
        Tags(
          direction: Axis.horizontal,
          horizontalScroll: true,
          itemCount: tags.length,
          itemBuilder: (index) {
            final item = tags[index];
            return ItemTags(
              index: index,
              title: item,
              activeColor: AppColors.sage,
              textStyle: TextStyle(fontSize: 16),
              removeButton: ItemTagsRemoveButton(
                backgroundColor: AppColors.silverMetallic,
                onRemoved: () => onRemoved(index),
              ),
              pressEnabled: false,
            );
          },
        )
      ],
    );
  }
}
