import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DeliveryDetailSiteWebMapWidget extends StatefulWidget {

  final GlobalKey<GoogleMapStateBase> googleKey;

  DeliveryDetailSiteWebMapWidget({this.googleKey});

  @override
  _DeliveryDetailSiteWebMapWidgetState createState() => _DeliveryDetailSiteWebMapWidgetState();
}

class _DeliveryDetailSiteWebMapWidgetState extends State<DeliveryDetailSiteWebMapWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeliveryDetailSiteModel detailSiteModel = Provider.of<DeliveryDetailSiteModel>(context);

    double initLat = detailSiteModel.deliveryDetailSites.isNotEmpty ? detailSiteModel.deliveryDetailSites[0].latitude : 37.575929;
    double initLng = detailSiteModel.deliveryDetailSites.isNotEmpty ? detailSiteModel.deliveryDetailSites[0].longitude : 126.976849;

    return Container(
      height: 200.0,
      child: GoogleMap(
        key: widget.googleKey,
        initialZoom: kIsWeb ? 16 : 15,
        initialPosition: GeoCoord(initLat, initLng),
        mapType: MapType.roadmap,
        interactive: true,
        mobilePreferences: const MobileMapPreferences(
          trafficEnabled: true,
          myLocationEnabled: true,
        ),
        webPreferences: WebMapPreferences(
          fullscreenControl: false,
          zoomControl: true,
          streetViewControl: true,
        ),
      ),
    );
  }
}