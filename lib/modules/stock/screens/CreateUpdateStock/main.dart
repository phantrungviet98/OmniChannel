import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataBloc.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataEvent.dart';
import 'package:omnichannel_flutter/bloc/LocationData/LocationDataState.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';
import 'package:omnichannel_flutter/data/modals/Stock.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockBloc.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockEvent.dart';
import 'package:omnichannel_flutter/modules/stock/bloc/CreateStock/CreateStockState.dart';
import 'package:omnichannel_flutter/modules/stock/widgets/LocationPicker/LocationPicker.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:omnichannel_flutter/widgets/CustomAppBar/main.dart';

class CreateUpdateStockScreenArgument {
  const CreateUpdateStockScreenArgument(this.stock);

  final Stock stock;
}

class CreateUpdateStockScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CreateUpdateStockScreen>
    with AfterLayoutMixin<CreateUpdateStockScreen> {
  bool _isUpdate = false;

  @override
  void afterFirstLayout(BuildContext context) {
    final argument = ModalRoute.of(context).settings.arguments
        as CreateUpdateStockScreenArgument;
    final locationDataBloc = BlocProvider.of<LocationDataBloc>(context);
    final createStockBloc = BlocProvider.of<CreateStockBloc>(context);

    this.setState(() {
      _isUpdate = argument?.stock != null;
    });

    if (_isUpdate) {
      final stock = argument?.stock;
      createStockBloc.add(UpdateStockEventInitData(CreateOneStockInput(
          name: stock?.name,
          cityCode: stock?.cityCode,
          address: stock?.address,
          phoneNumber: stock?.phoneNumber,
          districtCode: stock?.districtCode,
          wardCode: stock?.wardCode)));
    } else {
      createStockBloc.add(Reset());
      locationDataBloc.add(LocationDataEventGetCities());
    }
  }

  @override
  Widget build(BuildContext context) {
    final createStockBloc = BlocProvider.of<CreateStockBloc>(context);
    final params = ModalRoute.of(context).settings.arguments
        as CreateUpdateStockScreenArgument;

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Tạo kho',
          backgroundColor: AppColors.sage,
        ),
        body: BlocBuilder<LocationDataBloc, LocationDataState>(
          builder: (context, locationState) =>
              BlocConsumer<CreateStockBloc, CreateStockState>(
            listener: (context, state) {
              if (state.status == Status.success) {
                Navigator.pushReplacementNamed(
                    context, '/create-stock-success');
              }
            },
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
                            initialValue: params?.stock?.name,
                            onChanged: (text) => createStockBloc.add(
                                CreateStockEventDataChanged(
                                    CreateOneStockInput(name: text))),
                            decoration: InputDecoration(
                                labelText: 'Tên kho',
                                errorText: createStockState.error.nameError),
                          ),
                          TextFormField(
                            initialValue: params?.stock?.phoneNumber,
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
                            initialValue: params?.stock?.address,
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
                            hasError:
                                createStockState.error.districtError != null,
                            onChanged: (value) => createStockBloc.add(
                                CreateStockEventDataChanged(CreateOneStockInput(
                              districtCode: value,
                            ))),
                          ),
                          LocationPicker(
                            data: locationState.ward.data,
                            hint: 'Chọn phường, xã',
                            code: createStockState.createOneStockInput.wardCode,
                            status: locationState.ward.status,
                            hasError: createStockState.error.wardError != null,
                            onChanged: (value) => createStockBloc.add(
                                CreateStockEventDataChanged(CreateOneStockInput(
                              wardCode: value,
                            ))),
                          ),
                          AppButton(
                            loading:
                                createStockBloc.state.status == Status.loading,
                            title: !_isUpdate ? 'Tạo' : 'Cập nhật',
                            onPressed: () => createStockBloc.add(_isUpdate
                                ? UpdateStockEventRequest(params.stock.id)
                                : CreateStockEventRequest()),
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
