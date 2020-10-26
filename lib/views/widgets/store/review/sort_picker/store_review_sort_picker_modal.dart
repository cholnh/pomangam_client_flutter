import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/i18n/i18n.dart';
import 'package:pomangam_client_flutter/domains/store/review/store_review_sort_type.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/sort_picker/store_review_sort_picker_modal_item_widget.dart';

class StoreReviewSortPickerModal extends StatelessWidget {

  final StoreReviewSortType type;
  final Function(StoreReviewSortType) onSelected;

  StoreReviewSortPickerModal({this.type, this.onSelected});

  @override
  Widget build(BuildContext context) {
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
              StoreReviewSortPickerModalItemWidget(
                type: StoreReviewSortType.SORT_BY_DATE_DESC,
                isSelected: type == StoreReviewSortType.SORT_BY_DATE_DESC,
                onSelected: onSelected,
              ),
              //const Divider(height: 0.1),
              StoreReviewSortPickerModalItemWidget(
                type: StoreReviewSortType.SORT_BY_DATE_ASC,
                isSelected: type == StoreReviewSortType.SORT_BY_DATE_ASC,
                onSelected: onSelected,
              ),
              StoreReviewSortPickerModalItemWidget(
                type: StoreReviewSortType.SORT_BY_STAR_DESC,
                isSelected: type == StoreReviewSortType.SORT_BY_STAR_DESC,
                onSelected: onSelected,
              ),
              //const Divider(height: 0.1),
              StoreReviewSortPickerModalItemWidget(
                type: StoreReviewSortType.SORT_BY_STAR_ASC,
                isSelected: type == StoreReviewSortType.SORT_BY_STAR_ASC,
                onSelected: onSelected,
              ),
              //const Divider(height: 0.1),
              //const Divider(height: 0.1),
            ],
          )
        ],
      ),
    );
  }
}
