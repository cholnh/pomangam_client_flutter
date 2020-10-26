import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:provider/provider.dart';

import 'package:pomangam_client_flutter/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/detail/delivery_detail_site_model.dart';

class DeliveryDetailSiteItemsWidget extends StatefulWidget {

  final int dIdx;
  final GlobalKey<GoogleMapStateBase> googleKey;

  DeliveryDetailSiteItemsWidget({this.googleKey, this.dIdx});

  @override
  _DeliveryDetailSiteItemsWidgetState createState() => _DeliveryDetailSiteItemsWidgetState();
}

class _DeliveryDetailSiteItemsWidgetState extends State<DeliveryDetailSiteItemsWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Consumer<DeliveryDetailSiteModel>(
        builder: (_, model, __) {
          if(model.isFetching) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CupertinoActivityIndicator(),
            );
          }

          List<DeliveryDetailSite> detailSites = model.deliveryDetailSites;
          if(detailSites.length == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text('배달 가능한 상세지역이 없습니다.', style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12.0)),
            );
          }
          return _items(detailSites);
        },
      ),
    );
  }

  void _changeCameraPosition(double lat, double lng) async {
    double c = 0.0009;
    GoogleMap.of(widget.googleKey).moveCamera(GeoCoordBounds(
      northeast: GeoCoord(lat+c, lng+c),
      southwest: GeoCoord(lat-c, lng-c),
    ), padding: 0, animated: true);
  }

  Widget _items(List<DeliveryDetailSite> detailSites) {
    return Column(
      children: detailSites.map((DeliveryDetailSite detailSite) {
        return Column(
          children: <Widget>[
            _item(detailSite),
            Divider(thickness: 0.5, height: kIsWeb ? 1.0 : 0.5),
          ],
        );
      }).toList(),
    );
  }

  Widget _item(DeliveryDetailSite detailSite) {
    String title = detailSite.name;
    String subTitle = detailSite.location;

    return Consumer<DeliveryDetailSiteModel>(
      builder: (_, model, __) {
        return GestureDetector(
          onTap: () {
            model.changeSelected(detailSite);
            _changeCameraPosition(detailSite.latitude, detailSite.longitude);
          },
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.black.withOpacity(0.5), size: 15.0),
                Padding(padding: const EdgeInsets.only(right: 17.0)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(context).textTheme.headline1.color)),
                      Radio(
                        value: model.selected?.idx == detailSite.idx,
                        groupValue: true,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
