import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  bool loadingMap = true;
  GoogleMapController? mapController;
  LatLng? center;
  final Set<Marker> markers = {};
  String streetName = "الموقع؟؟";

  @override
  void onInit() async {
    // TODO: implement onInit
    getCurrentLocation();

    super.onInit();
  }

  Future<String> getStreetName() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          center?.latitude ?? .0, center?.longitude ?? .0);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        streetName = placemark.street ??
            placemark.subLocality ??
            placemark.locality ??
            placemark.country ??
            "";
        print(streetName);
        return streetName;
      }
    } catch (e) {

      print('Error: $e');
    }
    return '';
  }

  onPressedSelectLocation({CameraPosition? position}) async {
    print(center);
    print(position?.tilt);
  }

  getCurrentLocation() async {
    loadingMap = true;
    update();
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {}
    }
    if (permission == LocationPermission.deniedForever) {}
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      center = LatLng(position.latitude, position.longitude);

      update();
    }
    loadingMap = false;
    update();
  }

  void onCameraMove(CameraPosition position) {
    center = position.target;
    update();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    update();
  }
}
