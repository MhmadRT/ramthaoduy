import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ramtha/constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../helper/custom/custom_button.dart';
import 'location_controller.dart';

class PickLocationScreen extends StatelessWidget {
  final ValueChanged<LocationInfo>? onChanged;

  const PickLocationScreen({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        init: LocationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("اختر الموقع", style: TextStyle()),
              backgroundColor: AppColors.mainColor,
            ),
            body: controller.loadingMap
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Stack(
                    children: [
                      if (controller.center != null)
                        GoogleMap(

                            zoomControlsEnabled: false,
                            onMapCreated: controller.onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: controller.center!,
                              zoom: 14.0,
                            ),
                            markers: controller.markers,
                            onCameraMove: controller.onCameraMove),
                      if (controller.center != null)
                        Center(
                          child: Image.asset(
                            AppImages.iconPin,
                            height: 60,
                          ),
                        ),
                      if (controller.center == null)
                        const Center(child: Text('There are no permission')),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            width: Get.width / 2,
                            color: AppColors.mainColor,
                            title: "تحديد الموقع",
                            height: 50,
                            colorTitle: AppColors.whiteColor,
                            pressed: () async{
                              await controller.getStreetName();
                              LocationInfo locationInfo = LocationInfo(
                                  lat: controller.center?.latitude,
                                  lng: controller.center?.longitude,
                                  streetInfo: controller.streetName,);
                              onChanged?.call(locationInfo);
                              controller.onPressedSelectLocation();
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}

class LocationInfo {
  double? lat;
  double? lng;
  String? streetInfo;

  LocationInfo({this.lat, this.lng, this.streetInfo});
}
