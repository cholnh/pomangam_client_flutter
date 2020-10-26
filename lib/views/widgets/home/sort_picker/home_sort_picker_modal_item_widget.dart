import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/domains/sort/sort_type.dart';

class HomeSortPickerModalItemWidget extends StatelessWidget {

  final SortType type;
  final bool isSelected;
  final Function(SortType) onSelected;

  HomeSortPickerModalItemWidget({this.type, this.isSelected = false, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        title: isSelected
          ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('${convertSortTypeToText(type)}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Theme.of(Get.context).primaryColor)),
              const Padding(padding: EdgeInsets.all(3)),
              Icon(Icons.check, color: Theme.of(Get.context).primaryColor, size: 18.0)
            ],
          )
          : Text('${convertSortTypeToText(type)}', style: TextStyle(fontSize: 14.0)),
        onTap: () => onSelected(type),
      )
    );
  }
}
