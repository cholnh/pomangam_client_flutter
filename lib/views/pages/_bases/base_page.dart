import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/providers/help/help_model.dart';
import 'package:pomangam_client_flutter/providers/home/home_view_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/views/pages/home/home_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_page.dart';
import 'package:pomangam_client_flutter/views/pages/user_info/user_info_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/help_widget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class BasePage extends StatefulWidget {

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final PersistentTabController _tabController = Get.put(PersistentTabController());
  final PanelController _panelController = PanelController();
  final ScrollController _scrollController = ScrollController();

  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasOrder = (context.watch<OrderInfoModel>().todayOrders?.length ?? 0) != 0;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: PersistentTabView(
        controller: _tabController,
        screens: _buildScreens(),
        items: _navBarsItems(hasOrder: hasOrder),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).backgroundColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          colorBehindNavBar: Theme.of(context).backgroundColor,
          border: Border(
              top: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5
              )
          ),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration.zero,
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration.zero,
        ),
        navBarStyle: NavBarStyle.style2,
        padding: NavBarPadding.symmetric(horizontal: 5),
        navBarHeight: 55,
        onItemSelected: (index) async {
          switch(index) {
            case 0:
              context.read<HomeViewModel>().changeIsCurrent(true);
              break;
            case 1:
              context.read<HomeViewModel>().changeIsCurrent(false);
              context.read<OrderInfoModel>()
                ..clear()
                ..fetchToday(isForceUpdate: true);
              break;
            case 2:
              context.read<HomeViewModel>().changeIsCurrent(false);
              break;
          }
        },
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if(_panelController.isAttached && _panelController.isPanelOpen) {
      _panelController.close();
    }

    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ToastUtils.showToast(msg: '종료하려면 한번 더 누르세요.');
      return Future.value(false);
    }
    return Future.value(true);
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(
        scrollController: _scrollController,
        controller: _panelController,
        onHelpTap: _onHelpTap
      ),
      // PeriodicLandingPage(),
      OrderInfoPage(),
      UserInfoPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems({bool hasOrder = false}) {

    final Color activeColor = Theme.of(Get.context).primaryColor;
    final Color inactiveColor = Theme.of(Get.context).iconTheme.color;
    final double iconSize = 23;
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home, size: iconSize),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(CupertinoIcons.time, size: iconSize),
      //   activeColor: activeColor,
      //   inactiveColor: inactiveColor,
      //   title: '정기배달'
      // ),
      PersistentBottomNavBarItem(
        icon: Badge(
          key: context.watch<HelpModel>().keyButton5,
          showBadge: hasOrder,
          badgeContent: Container(),
          padding: const EdgeInsets.all(2),
          elevation: 0.0,
          position: BadgePosition.topEnd(top: 0, end: -5),
          child: Icon(CupertinoIcons.news, size: iconSize)
        ),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.ellipsis, size: iconSize),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
    ];
  }

  void _onHelpTap({req}) {
    _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    TutorialCoachMark(
      context,
      targets: targetFocus(),
      colorShadow: Colors.black,
      alignSkip: Alignment.bottomRight,
      opacityShadow: 0.85,
      textSkip: "건너뛰기",
      onFinish: (){
        //print("finish");
      },
      onClickTarget: (target){
        //print(target);
      },
      onClickSkip: (){
        //print("skip");
      },
    )..show();
  }
}
