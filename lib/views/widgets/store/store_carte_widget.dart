import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/store/detail_view_page.dart';
import 'package:provider/provider.dart';

class StoreCarteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StoreModel storeModel = context.watch();

    return SliverToBoxAdapter(
      key: PmgKeys.storeStory,
      child: Container(
        height: 35,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: FlatButton(
          onPressed: () => open(imagePaths: storeModel.store.stories.first.images),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.black12)
          ),
          color: Theme.of(Get.context).backgroundColor,
          child: Container(
            child: Text(
                '식단표 보기',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center
            ),
          ),
        ),
      )
    );
  }

  void open({int initialIndex = 0, List imagePaths}) {
    Get.to(DetailViewPage(
        initialIndex: initialIndex,
        imagePaths: imagePaths
    ), duration: Duration.zero);
  }
}
