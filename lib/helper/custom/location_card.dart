import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class LocationMapWidget extends StatelessWidget {
  final double lat;
  final double lng;
  final double? height;
  final double? width;
  final String? title;

  LocationMapWidget(
      {super.key, required this.lat, required this.lng, this.height,this.title,this.width});

  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
        markerId: const MarkerId('Current Position'),
        draggable: false,
        position: LatLng(lat, lng)));
    LatLng pinPosition = LatLng(lat, lng);
    CameraPosition initialLocation =
        CameraPosition(zoom: 14, bearing: 30, target: pinPosition);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: height ?? 178,
        width: width ?? Get.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(45)),
        child: Stack(
          children: [
            // GoogleMap(
            //   myLocationButtonEnabled: false,
            //   zoomControlsEnabled: true,
            //   zoomGesturesEnabled: true,
            //   myLocationEnabled: false,
            //   onCameraMove: (position) {},
            //   markers: _markers,
            //   initialCameraPosition: initialLocation,
            //   onMapCreated: (GoogleMapController controller) {
            //     // _controller.complete(controller);
            //   },
            // ),
            Image.asset(
              AppImages.map,
              fit: BoxFit.cover,
              height: 178,
              width: Get.width,
            ),
            Container(
              height: 178,
              width: Get.width,
              color: Colors.black38,
            ),
            const Center(
              child: Icon(
                Icons.location_on_rounded,
                size: 30,
                color: AppColors.red,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    openMap(lat, lng);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(7)),
                        child:   Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text(
                            title??"اذهب الى الموقع",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
