//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:provider/provider.dart';
//import 'package:pomangam_client_flutter/domains/deliverysite/detail/delivery_detail_site.dart';
//import 'package:pomangam_client_flutter/providers/deliverysite/detail/delivery_detail_site_model.dart';
//
//class DeliveryDetailSiteAppMapWidget extends StatefulWidget {
//
//  final Completer<GoogleMapController> controller;
//
//  DeliveryDetailSiteAppMapWidget(this.controller);
//
//  @override
//  _DeliveryDetailSiteAppMapWidgetState createState() => _DeliveryDetailSiteAppMapWidgetState();
//}
//
//class _DeliveryDetailSiteAppMapWidgetState extends State<DeliveryDetailSiteAppMapWidget> {
//  BitmapDescriptor _markerIcon;
//
//  @override
//  Widget build(BuildContext context) {
//    DeliveryDetailSiteModel detailSiteModel = Provider.of<DeliveryDetailSiteModel>(context, listen: false);
//    Set<Marker> markers = Set();
//    detailSiteModel.deliveryDetailSites.forEach((DeliveryDetailSite detailSite) {
//      markers.add(Marker(
//          markerId: MarkerId('${detailSite.name}-${detailSite.idx}'),
//          position: LatLng(detailSite.latitude, detailSite.longitude),
//          visible: true,
//          consumeTapEvents: true,
//          alpha: 0.9,
//          infoWindow: InfoWindow(
//            snippet: 'snippet',
//            title: '${detailSite.name}',
//          ),
//          onTap: () {
//            detailSiteModel.changeSelected(detailSite);
//            _changeCameraPosition(detailSite.latitude, detailSite.longitude);
//          },
//          icon: _markerIcon
//      ));
//    });
//
//    double initLat = detailSiteModel.deliveryDetailSites.isNotEmpty ? detailSiteModel.deliveryDetailSites[0].latitude : 37.575929;
//    double initLng = detailSiteModel.deliveryDetailSites.isNotEmpty ? detailSiteModel.deliveryDetailSites[0].longitude : 126.976849;
//
//    return Container(
//      height: 200.0,
//      child: GoogleMap(
//        mapType: MapType.normal,
//        initialCameraPosition: CameraPosition(
//          target: LatLng(initLat, initLng),
//          zoom: 15,
//        ),
//        onMapCreated: (GoogleMapController controller) {
//           widget.controller.complete(controller);
//        },
//        markers: markers,
//        myLocationEnabled: true,
//        myLocationButtonEnabled: true,
//        zoomControlsEnabled: false,
//        compassEnabled: true,
//        zoomGesturesEnabled: true,
//        rotateGesturesEnabled: false,
//        scrollGesturesEnabled: true,
//        tiltGesturesEnabled: false,
//      ),
//    );
//  }
//
//  void _changeCameraPosition(double lat, double lng) async {
//    final GoogleMapController controller = await widget.controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//      target: LatLng(lat, lng),
//      zoom: 16.5,
//    )));
//  }
//
//  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
//    if (_markerIcon == null) {
//      final ImageConfiguration imageConfiguration =
//      createLocalImageConfiguration(context);
//      BitmapDescriptor.fromAssetImage(
//          imageConfiguration, 'assets/logo.png')
//          .then(_updateBitmap);
//    }
//  }
//
//  void _updateBitmap(BitmapDescriptor bitmap) {
//    setState(() {
//      _markerIcon = bitmap;
//    });
//  }
//}
