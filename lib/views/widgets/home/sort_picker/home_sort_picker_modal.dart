import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/i18n/i18n.dart';
import 'package:pomangam_client_flutter/domains/sort/sort_type.dart';
import 'package:pomangam_client_flutter/providers/sort/home_sort_model.dart';
import 'package:pomangam_client_flutter/views/widgets/home/sort_picker/home_sort_picker_modal_item_widget.dart';
import 'package:provider/provider.dart';

class HomeSortPickerModal extends StatelessWidget {

  final Function(SortType) onSelected;

  HomeSortPickerModal({this.onSelected});

  @override
  Widget build(BuildContext context) {
    HomeSortModel sortModel = context.watch();
    SortType type = sortModel.sortType;
    
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  '${Messages.sortPickerTitle}',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1.color
                  )
                ),
              ),
              Divider(height: 0.0, thickness: 4.0, color: Colors.black.withOpacity(0.03)),
              HomeSortPickerModalItemWidget(
                type: SortType.SORT_BY_RECOMMEND_DESC,
                isSelected: type == SortType.SORT_BY_RECOMMEND_DESC,
                onSelected: onSelected,
              ),
              //const Divider(height: 0.1),
              HomeSortPickerModalItemWidget(
                type: SortType.SORT_BY_ORDER_DESC,
                isSelected: type == SortType.SORT_BY_ORDER_DESC,
                onSelected: onSelected,
              ),
              //const Divider(height: 0.1),
              HomeSortPickerModalItemWidget(
                type: SortType.SORT_BY_STAR_DESC,
                isSelected: type == SortType.SORT_BY_STAR_DESC,
                onSelected: onSelected,
              ),
              //const Divider(height: 0.1),
              HomeSortPickerModalItemWidget(
                type: SortType.SORT_BY_REVIEW_DESC,
                isSelected: type == SortType.SORT_BY_REVIEW_DESC,
                onSelected: onSelected,
              ),
              //const Divider(height: 0.1),
            ],
          )
        ],
      ),
    );
  }
}
