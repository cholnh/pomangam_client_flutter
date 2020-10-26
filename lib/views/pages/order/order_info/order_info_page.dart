import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/order_info_current_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/order_info_history_widget.dart';
import 'package:provider/provider.dart';

class OrderInfoPage extends StatefulWidget  {

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> with SingleTickerProviderStateMixin {

  bool isFirst;
  TabController tabController;

  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          toolbarHeight: 48,
          automaticallyImplyLeading: false,
          elevation: 1.0,
          flexibleSpace: SafeArea(
            child: TabBar(
              controller: tabController,
              labelColor: Colors.black,
              indicatorColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).textTheme.subtitle2.color,
              tabs: [
                Tab(child: Consumer<OrderInfoModel>(
                  builder: (_, model, __) {
                    int orderCount = model.countTodayOrders ?? 0;

                    return Badge(
                      elevation: 0.0,
                      showBadge: orderCount != 0,
                      badgeContent: Text(orderCount.toString(), style: TextStyle(color: Colors.white, fontSize: 12)),
                      badgeColor: Theme.of(context).primaryColor,
                      position: BadgePosition.topEnd(top: -4, end: -25),
                      child: Text('내 주문', style: TextStyle(
                        fontSize: 15, color: Theme.of(context).textTheme.headline1.color
                      )),
                    );
                  },
                )),
                Tab(child: Text('주문 내역', style: TextStyle(
                  fontSize: 15, color: Theme.of(context).textTheme.headline1.color
                ))),
              ],
            ),
          )
        ),
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              OrderInfoCurrentWidget(),
              OrderInfoHistoryWidget()
            ]
          )
        ),
      ),
    );
  }
}
