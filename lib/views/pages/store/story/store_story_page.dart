import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:story_viewer/story_viewer.dart';

class StoreStoryPage extends StatelessWidget {

  final String heroTag;
  final String title;
  final String icon;
  final List<String> images;

  StoreStoryPage({this.heroTag, this.title, this.icon, this.images});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StoryViewer(
        heroTag: heroTag,

        backgroundColor: Colors.white,
        stories: [
          for(String image in images)
            StoryItemModel(imageProvider: CachedNetworkImageProvider('${Endpoint.serverDomain}/$image')),
        ],
        customValues: Customizer(
          closeIcon: CupertinoIcons.clear,
        ),
        userModel: UserModel(
          username: title,
          profilePictureUrl: '${Endpoint.serverDomain}/$icon',
        ),
      ),
    );
  }
}
