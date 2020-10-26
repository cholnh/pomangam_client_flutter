import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/domains/store/store.dart';
import 'package:pomangam_client_flutter/domains/store/story/store_story.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/pages/store/story/store_story_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class StoreStoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StoreModel storeModel = context.watch();

    return SliverToBoxAdapter(
      key: PmgKeys.storeStory,
      child: Column(
        children: <Widget>[
          if(storeModel.isStoreFetching || !storeModel.store.stories.isNullOrBlank) Container(
            padding: EdgeInsets.only(top: 20.0),
            height: 135,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: storeModel.isStoreFetching
                ? _loading()
                : _items(storeModel.store)
            ),
          )
          else SizedBox(height: 30),
          Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5)
        ],
      ),
    );
  }

  List<Widget> _loading() {
    int r = Random().nextInt(7) + 1;
    return List.generate(r, (index) => Container(
      margin: EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomShimmer(width: 65, height: 65, borderRadius: BorderRadius.circular(50.0)),
          ),
          CustomShimmer(width: 50, height: 12)
        ],
      ),
    ));
  }

  List<Widget> _items(Store store) {
    List<Widget> items = List();
    for(int i=0; i<store.stories.length; i++) {
      StoreStory story = store.stories[i];
      items.add(GestureDetector(
        onTap: () => _onTap(
          heroTag: 'story${story.idx}',
          title: store.storeInfo.name,
          icon: store.brandImagePath,
          images: story.images
        ),
        child: Container(
          margin: EdgeInsets.only(left: 15.0, right: i == store.stories.length - 1 ? 15.0 : 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                width: 65.0,
                height: 65.0,
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black26,
                    width: 1.0,
                  ),
                ),
                child: Hero(
                  tag: 'story${story.idx}',
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          '${Endpoint.serverDomain}/${story.images.first}?v=${story.modifyDate}',
                        ),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 65,
                child: Text(
                  '${story.title}',
                  style: TextStyle(fontSize: 12.0, color: Theme.of(Get.context).textTheme.headline1.color),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ));
    }
    return items;
  }

  void _onTap({String heroTag, String title, String icon, List<String> images}) {
    Navigator.of(Get.context).push(PageRouteBuilder(
      fullscreenDialog: true,
      transitionDuration: Duration(milliseconds: 300),
      opaque: false, // set to false
      pageBuilder: (_, __, ___) => StoreStoryPage(
        heroTag: heroTag,
        title: title,
        icon: icon,
        images: images,
      ),
    ));
  }
}
