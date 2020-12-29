import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_subscribe_info/item/order_subscribe_info_item_widget.dart';

class OrderSubscribeInfoPage extends StatefulWidget {

  @override
  _OrderSubscribeInfoPageState createState() => _OrderSubscribeInfoPageState();
}

class _OrderSubscribeInfoPageState extends State<OrderSubscribeInfoPage> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: '정기 배달'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Text('주문내역이 없습니다.')
          ),
        )
//        SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                //OrderSubscribeInfoItemWidget(),
//              ],
//            )
//        )
      ),
    );
  }
}
