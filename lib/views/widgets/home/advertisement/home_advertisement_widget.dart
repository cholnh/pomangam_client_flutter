import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/advertisement/advertisement.dart';
import 'package:pomangam_client_flutter/providers/advertisement/advertisement_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class HomeAdvertisementWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.deliveryAdvertisement,
      child: Consumer<AdvertisementModel>(
        builder: (_, model, child) {
          if(model.isAdvertisementFetching) return _shimmer();
          if(model.advertisements.isEmpty) return Container();
          if(model.advertisements.length == 1) return _item(model.advertisements.first);
          return CarouselSlider(
            options: CarouselOptions(
              height: 160.0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: _advertisementWidgets(model.advertisements)
          );
        },
      )
    );
  }

  List<Widget> _advertisementWidgets(List<Advertisement> advertisements) {
    return advertisements?.map((ad) {
      return Builder(builder: (BuildContext context) => _item(ad));
    })?.toList();
  }

  Widget _item(Advertisement ad) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(Get.context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white70
        ),
        child: CachedNetworkImage(
          imageUrl: '${Endpoint.serverDomain}/${ad.imagePath}?v=${ad.modifyDate}',
          fit: BoxFit.fill,
          width: MediaQuery.of(Get.context).size.width,
          height: 200,
          placeholder: (_, __) => CustomShimmer(
            width: MediaQuery.of(Get.context).size.width,
            height: 160,
            borderRadius: BorderRadius.zero
          ),
          errorWidget: (context, error, stackTrace) => Icon(Icons.error_outline)
        )
      ),
      onTap: () => ad.nextLocation == null ? {} : _next(ad.nextLocation),
    );
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomShimmer(
          width: MediaQuery.of(Get.context).size.width,
          height: 160,
          borderRadius: BorderRadius.zero
      ),
    );
  }

  void _next(String url) async {
    Get.toNamed('$url');
  }
}
