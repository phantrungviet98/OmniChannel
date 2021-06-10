import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataBloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataEvent.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataState.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockBloc.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockEvent.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockState.dart';
import 'package:omnichannel_flutter/modules/stock/widgets/LocationPicker/LocationPicker.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class CreateStockScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CreateStockScreen> {
  @override
  void initState() {
    final locationDataBloc = BlocProvider.of<LocationDataBloc>(context);
    if (locationDataBloc.state.city.data.isEmpty) {
      locationDataBloc.add(LocationDataEventGetCities());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createStockBloc = BlocProvider.of<CreateStockBloc>(context);

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Tạo kho',
          backgroundColor: AppColors.sage,
        ),
        body: BlocBuilder<LocationDataBloc, LocationDataState>(
          builder: (context, locationState) =>
              BlocBuilder<CreateStockBloc, CreateStockState>(
            builder: (context, createStockState) {
              return Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return Column(
                        children: [
                          TextFormField(
                            onChanged: (text) => createStockBloc.add(
                                CreateStockEventDataChanged(
                                    CreateOneStockInput(name: text))),
                            decoration: InputDecoration(
                                labelText: 'Tên kho',
                                errorText: createStockState.error.nameError),
                          ),
                          TextFormField(
                            onChanged: (text) => createStockBloc.add(
                                CreateStockEventDataChanged(
                                    CreateOneStockInput(phoneNumber: text))),
                            decoration: InputDecoration(
                              labelText: 'Số điện thoại',
                              errorText:
                                  createStockState.error.phoneNumberError,
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          TextFormField(
                            onChanged: (text) => createStockBloc.add(
                                CreateStockEventDataChanged(
                                    CreateOneStockInput(address: text))),
                            decoration: InputDecoration(
                                labelText: 'Địa chỉ',
                                errorText: createStockState.error.addressError),
                          ),
                          LocationPicker(
                            data: locationState.city.data,
                            hint: 'Chọn thành phố',
                            code: createStockState.createOneStockInput.cityCode,
                            status: locationState.city.status,
                            hasError: createStockState.error.cityError != null,
                            onChanged: (value) => createStockBloc.add(
                                CreateStockEventDataChanged(
                                    CreateOneStockInput(cityCode: value))),
                          ),
                          LocationPicker(
                            data: locationState.district.data,
                            hint: 'Chọn quận, huyện',
                            code: createStockState
                                .createOneStockInput.districtCode,
                            status: locationState.district.status,
                            hasError: createStockState.error.districtError != null,
                            onChanged: (value) => createStockBloc.add(
                                CreateStockEventDataChanged(
                                    CreateOneStockInput(
                                      districtCode: value,
                                    ))),
                          ),
                          LocationPicker(
                            data: locationState.ward.data,
                            hint: 'Chọn phường, xã',
                            code: createStockState
                                .createOneStockInput.wardCode,
                            status: locationState.ward.status,
                            hasError: createStockState.error.wardError != null,
                            onChanged: (value) => createStockBloc.add(
                                CreateStockEventDataChanged(
                                    CreateOneStockInput(
                                      wardCode: value,
                                    ))),
                          ),
                          AppButton(
                            title: 'Tạo',
                            onPressed: () =>
                                createStockBloc.add(CreateStockEventRequest()),
                          )
                        ],
                      );
                    }, childCount: 1))
                  ],
                ),
              );
            },
          ),
        ));
  }
}
