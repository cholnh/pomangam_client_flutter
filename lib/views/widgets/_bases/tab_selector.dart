import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/i18n/i18n.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/domains/tab/tab_menu.dart';
import 'package:pomangam_client_flutter/providers/tab/tab_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_bottom_navbar_item.dart';
import 'package:provider/provider.dart';

class TabSelector extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Color selectedItemColor = Colors.black;
    final Color unselectedItemColor = Colors.grey;

    return SafeArea(
      child: Consumer<TabModel>(
        builder: (_, model, __) {
          return BottomNavigationBar(
            key: PmgKeys.baseTab,
            type: BottomNavigationBarType.fixed,
            currentIndex: TabMenu.values.indexOf(model.tab),
            onTap: (index) => model.change(TabMenu.values[index]),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0.0,
            unselectedFontSize: 0.0,
            backgroundColor: Theme.of(Get.context).backgroundColor,
            selectedItemColor: selectedItemColor,
            unselectedItemColor: unselectedItemColor,
            elevation: 0.0,
            items: [
              CustomBottomNavBarItem(
                  icon: const Icon(Icons.home, key: PmgKeys.tabHomeImg),
                  title: Messages.tabHomeTitle,
                  isActive: false,
                  selectedItemColor: selectedItemColor,
                  unselectedItemColor: unselectedItemColor
              ),
//                CustomBottomNavBarItem(
//                    icon: const Icon(Icons.fastfood, key: PmgKeys.tabRecommendImg),
//                    title: Messages.tabRecommendTitle,
//                    isActive: false,
//                    selectedItemColor: selectedItemColor,
//                    unselectedItemColor: unselectedItemColor
//                ),
              CustomBottomNavBarItem(
                  icon: const Icon(Icons.event_note, key: PmgKeys.tabOrderInfoImg),
                  title: Messages.tabOrderInfoTitle,
                  isActive: false,
                  selectedItemColor: selectedItemColor,
                  unselectedItemColor: unselectedItemColor
              ),
              CustomBottomNavBarItem(
                  icon: const Icon(Icons.more_horiz, key: PmgKeys.tabMoreImg),
                  title: Messages.tabMoreTitle,
                  isActive: false,
                  selectedItemColor: selectedItemColor,
                  unselectedItemColor: unselectedItemColor
              ),
            ]
          );
        },
      ),
    );
  }
}