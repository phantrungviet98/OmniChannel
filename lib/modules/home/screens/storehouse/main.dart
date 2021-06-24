import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:omnichannel_flutter/assets/json/JsonAnimates.dart';
import 'package:omnichannel_flutter/common/colors/Colors.dart';
import 'package:omnichannel_flutter/common/fonts/FontSize.dart';
import 'package:omnichannel_flutter/common/ui/BaseScreen.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/modals/home-modals.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseBloc.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseEvent.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseState.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/widgets/StorehouseItem.dart';
import 'package:omnichannel_flutter/modules/stock/screens/CreateUpdateStock/main.dart';
import 'package:omnichannel_flutter/utis/ui/Shadow.dart';

class StorehouseScreen extends BaseScreenStateful {
  static final theme = ScreenTheme(
      color: AppColors.sage, title: 'Kho hàng', icon: Icons.storefront);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<StorehouseScreen> {
  @override
  void initState() {
    final bloc = BlocProvider.of<StorehouseBloc>(context);
    if (bloc.state.stocks.isEmpty) {
      bloc.add(StoreHouseEventGetStocks());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorehouseBloc, StorehouseState>(
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async => BlocProvider.of<StorehouseBloc>(context).add(StoreHouseEventGetStocks()),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final stock = state.stocks[index];
                    return Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
                      decoration: BoxDecoration(
                          boxShadow: [Shadow.light],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              StorehouseItem(
                                icon: Icon(
                                  Icons.store,
                                  color: AppColors.sage,
                                ),
                                label: stock.name,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.big),
                              )
                            ],
                          ),
                          Container(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StorehouseItem(
                                icon: Icon(
                                  Icons.contact_phone,
                                  color: AppColors.sage,
                                ),
                                label: stock.phoneNumber,
                              ),
                            ],
                          ),
                          Container(
                            height: 8,
                          ),
                          Row(
                            children: [
                              StorehouseItem(
                                icon: Icon(
                                  Icons.location_pin,
                                  color: AppColors.sage,
                                ),
                                label: stock.address,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StorehouseItem(
                                icon: Icon(
                                  Icons.location_city,
                                  color: AppColors.sage,
                                ),
                                label: stock.city.label,
                              ),
                              StorehouseItem(
                                label: stock.district.label,
                              ),
                              StorehouseItem(
                                label: stock.ward.label,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            padding: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: AppColors.sage))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/create-update-stock',
                                        arguments:
                                        CreateUpdateStockScreenArgument(
                                            stock));
                                  },
                                  child: Icon(Icons.edit),
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }, childCount: state.stocks.length),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: state.status == Status.loading
                ? Lottie.asset(JsonAnimates.loadingCircles, height: 60)
                : Icon(Icons.add),
            onPressed: () =>
                Navigator.pushNamed(context, '/create-update-stock'),
            backgroundColor: AppColors.sage,
          ),
        );
      },
    );
  }
}
