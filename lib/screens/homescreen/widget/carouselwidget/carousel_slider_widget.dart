import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import '../../../../constant/app_colors.dart';
import 'carousel_slider_controller.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarouselSliderController>(
        init: CarouselSliderController(),
        builder: (controller) {
          return CarouselSlider.builder(
            itemCount: controller.sliderList.length,
            itemBuilder: (context, index, r) {
              final urlImages = controller.sliderList[index].image;
              return buildImage(controller.sliderList[index]);
            },
            options: CarouselOptions(
              onPageChanged: (index, r) {
                controller.inActiveBox = index;
                controller.update();
              },
              enlargeCenterPage: true,
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: 1,
            ),
          );
        });
  }

  Widget buildImage(SliderInfo sliderInfo) => SizedBox(
        height: 200,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 4,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                ),
                width: double.infinity,
                height: 200,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: isImage(sliderInfo.image ?? "")
                            ? CachedNetworkImage(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.fill,
                                imageUrl: sliderInfo.image ?? '',
                                placeholder: (context, url) =>
                                    const CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) => const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ))
                            : const SizedBox()),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         deleteBanner(greeting.serial ?? "");
                    //       },
                    //       child: Container(
                    //         decoration: const BoxDecoration(
                    //             color: AppColors.pink1, shape: BoxShape.circle),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(5.0),
                    //           child: SvgPicture.asset(
                    //             AssetImages.closeBottomSheet,
                    //             color: AppColors.white,
                    //             width: 10,
                    //             height: 10,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  static bool isImage(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType?.startsWith('image/') ?? false;
  }
}
