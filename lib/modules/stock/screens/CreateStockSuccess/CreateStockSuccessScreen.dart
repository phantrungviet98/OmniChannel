import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseEvent.dart';
import 'package:omnichannel_flutter/widgets/Button/main.dart';
import 'package:omnichannel_flutter/modules/home/screens/storehouse/bloc/StorehouseBloc.dart';


class CreateStockSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_am12icze.json'),
            Text(
              'Tạo kho hàng thành công',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(padding: EdgeInsets.only(top: 10), child: AppButton(
              title: 'Tiếp tục trải nghiệm',
              onPressed: () {
                BlocProvider.of<StorehouseBloc>(context).add(StoreHouseEventGetStocks());
                Navigator.pop(context);
              },
            ),)
          ],
        ),
      ),
    );
  }
}
