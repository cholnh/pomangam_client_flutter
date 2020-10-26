import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/domains/sort/sort_type.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/help/help_model.dart';
import 'package:pomangam_client_flutter/providers/home/home_contents_view_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/providers/sort/home_sort_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_summary_model.dart';
import 'package:pomangam_client_flutter/views/widgets/home/sort_picker/home_sort_picker_modal.dart';
import 'package:pomangam_client_flutter/views/widgets/home/time_picker/home_time_picker_modal.dart';
import 'package:provider/provider.dart';

import 'item/home_contents_type.dart';

class HomeContentsBarWidget extends StatelessWidget {

  final Function onChangedTime;
  final Function onChangedSort;

  HomeContentsBarWidget({this.onChangedTime, this.onChangedSort});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: PmgKeys.deliveryContentsBar,
      backgroundColor: Theme.of(Get.context).backgroundColor,
      floating: false,
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 0.3,
      title: Consumer<OrderTimeModel>(
        builder: (_, model, child) {
          if(model.userOrderTime.isNull || model.userOrderDate.isNull) {
            return Row(
              children: [
                Icon(Icons.error_outline, color: Theme.of(Get.context).primaryColor, size: 18),
                SizedBox(width: 3),
                Text('오류 (앱을 다시 실행해주세요)', style: TextStyle(fontSize: 12.0, color: Theme.of(Get.context).primaryColor)),
              ],
            );
          }
          bool isNextDay = model.userOrderDate?.isAfter(DateTime.now());
          var textArrivalDate = isNextDay ? ' (${DateFormat('MM월 dd일').format(model.userOrderDate)})' : '';
          int h = model.userOrderTime.getArrivalDateTime().hour;
          int m = model.userOrderTime.getArrivalDateTime().minute;
          var textMinute = m == 0 ? '' : '$m분 ';
          var textArrivalTime = '$h시 $textMinute' + (isNextDay ? '예약' : '도착');
          return InkWell(
            child: Row(
              children: <Widget>[
                Text('$textArrivalTime$textArrivalDate', key: context.read<HelpModel>().keyButton2, style: const TextStyle(fontSize: 16.0, color: Colors.black)),
                Icon(Icons.arrow_drop_down, color: Theme.of(Get.context).primaryColor)
              ],
            ),
            onTap: () => _showModal(
                widget: HomeTimePickerModal(onSelected: onChangedTime)
            )
          );
        }
      ),
      actions: <Widget>[
        Consumer<HomeSortModel>(
          builder: (_, sortModel, __) {
            SortType sortType = sortModel.sortType;
            return GestureDetector(
              onTap: () => _showModal(
                  widget: HomeSortPickerModal(onSelected: _selectSort)
              ),
              child: Material(
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Center(child: Text('${convertSortTypeToText(sortType)}', style: TextStyle(fontSize: 10.0, color: Theme.of(context).textTheme.headline1.color))),
                    SizedBox(width: 3),
                    Icon(Icons.swap_vert, color: Theme.of(context).textTheme.headline1.color, size: 16),
                    SizedBox(width: 15)
                  ],
                ),
              )
            );
          }
        ),
        Consumer<HomeContentsViewModel>(
          builder: (_, model, __) {
            bool isListType = model.contentsType == HomeContentsType.LIST;
            return GestureDetector(
              onTap: _changeContentsView,
              child: Row(
                key: context.read<HelpModel>().keyButton4,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                        color: isListType
                          ? Colors.black.withOpacity(0.5)
                          : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft:  Radius.circular(5.0),
                        ),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                          width: 0.5
                        )
                    ),
                    child: Icon(
                      Icons.format_list_bulleted,
                      color: isListType
                        ? Colors.white
                        : Colors.black.withOpacity(0.5),
                      size: 20
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                        color: !isListType
                          ? Colors.black.withOpacity(0.5)
                          : Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomRight:  Radius.circular(5.0),
                        ),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                          width: 0.5
                        )
                    ),
                    child: Icon(
                      Icons.apps,
                      color: !isListType
                        ? Colors.white
                        : Colors.black.withOpacity(0.5),
                      size: 20
                    )
                  )
                ],
              ),
            );
          },
        ),
        Padding(padding: const EdgeInsets.only(right: 10.0))
      ],
    );
  }

  void _changeContentsView() {
    Get.context.read<HomeContentsViewModel>().toggleHomeContentsType();
  }

  void _showModal({Widget widget}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))
      ),

      isScrollControlled: true,
      context: Get.context,
      builder: (context) {
        return widget;
      }
    );
  }

  void _selectSort(SortType sortType) async {
    Get.context.read<HomeSortModel>().changeSortType(sortType, notify: true);

    DeliverySiteModel deliverySiteModel = Get.context.read();
    OrderTimeModel orderTimeModel = Get.context.read();

    // store summary fetch
    Get.context.read<StoreSummaryModel>()
    ..clear()
    ..fetch(
      isForceUpdate: true,
      dIdx: deliverySiteModel.userDeliverySite?.idx,
      oIdx: orderTimeModel.userOrderTime?.idx,
      oDate: orderTimeModel.userOrderDate,
      sortType: sortType
    );

    Get.back();
    onChangedSort();
  }
}
