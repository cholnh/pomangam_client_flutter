import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/domains/store/review/store_review_sort_type.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/store/review/StoreReviewSortModel.dart';
import 'package:pomangam_client_flutter/providers/store/review/store_review_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/custom_refresher.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/sort_picker/store_review_sort_picker_modal.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/store_review_contents_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/store_review_notice_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoreReviewPage extends StatefulWidget {

  final int sIdx;

  StoreReviewPage({this.sIdx});

  @override
  _StoreReviewPageState createState() => _StoreReviewPageState();
}

class _StoreReviewPageState extends State<StoreReviewPage> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreModel>(
      builder: (_, model, __) {
        return  Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: BasicAppBar(
            leadingIcon: Icon(CupertinoIcons.back, size: 20, color: Colors.black),
            elevation: 1.0,
            title: '리뷰',
            actions: [
              Consumer<StoreReviewSortModel>(
                builder: (_, sortModel, __) {
                  StoreReviewSortType sortType = sortModel.sortType;
                  return GestureDetector(
                    onTap: () => _showModal(
                      widget: StoreReviewSortPickerModal(type: sortType, onSelected: _selectSort)
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Center(child: Text('${convertStoreReviewSortTypeToText(sortType)}', style: TextStyle(fontSize: 10.0, color: Theme.of(context).textTheme.headline1.color))),
                          SizedBox(width: 3),
                          Icon(Icons.swap_vert, color: Theme.of(context).textTheme.headline1.color, size: 16),
                          SizedBox(width: 15)
                        ],
                      ),
                    )
                  );
                }
              )
            ],
          ),
          body: SafeArea(
            child: Consumer<StoreReviewModel>(
              builder: (_, model, __) {
                if(model.isFetching) return _shimmerWidget();
                if(model.reviews.isEmpty) return _emptyWidget();
                return CustomRefresher(
                  controller: _refreshController,
                  onLoading: _loading,
                  onRefresh: _refresh,
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      StoreReviewNoticeWidget(),
                      StoreReviewContentsWidget(reviews: model.reviews)
                    ]
                  )
                );
              }
            )
          )
        );
      }
    );
  }

  Future<void> _refresh() async {
    _refreshController.loadComplete();
    context.read<StoreReviewModel>().clear(notify: false);
    await _loading(isForceUpdate: true);
    _refreshController.refreshCompleted();
  }

  Future<void> _loading({bool isForceUpdate = false}) async {
    StoreReviewModel storeReviewModel = context.read();
    if(storeReviewModel.hasNext) {
      await storeReviewModel.fetchAll(
        isForceUpdate: isForceUpdate,
        dIdx: context.read<DeliverySiteModel>().userDeliverySite.idx,
        sIdx: widget.sIdx,
        sortType: context.read<StoreReviewSortModel>().sortType
      );
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  Widget _emptyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Center(
        child: Text('리뷰가 없습니다.', style: TextStyle(
          color: Theme.of(context).textTheme.subtitle2.color,
          fontSize: 12.0
        ))
      )
    );
  }

  Widget _shimmerWidget() {
    return Center(child: CupertinoActivityIndicator());
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

  void _selectSort(StoreReviewSortType sortType) async {
    Get.back();
    Get.context.read<StoreReviewSortModel>().changeSortType(sortType, notify: true);

    // review fetch
    context.read<StoreReviewModel>()
    ..clear()
    ..fetchAll(
      dIdx: context.read<DeliverySiteModel>().userDeliverySite.idx,
      sIdx: widget.sIdx,
      sortType: sortType
    );
  }
}
