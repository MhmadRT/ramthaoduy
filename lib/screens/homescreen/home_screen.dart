import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/helper/custom/custom_card_info.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/helper/custom/no_data_widget.dart';
import 'package:ramtha/screens/homescreen/home_conrtoller.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:ramtha/screens/homescreen/widget/carouselwidget/carousel_slider_controller.dart';
import 'package:ramtha/screens/homescreen/widget/filtter_bottom_sheet.dart';
import 'package:ramtha/screens/searchscreen/search_sceen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../helper/custom/custom_text_feild.dart';
import '../../network/api_urls.dart';
import '../mainscreen/main_controller.dart';
import 'widget/carouselwidget/carousel_slider_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Column(
            children: [
              Row(
                children: [
                  GetBuilder<MainController>(
                      init: MainController(),
                      builder: (mainController) {
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(()=>const SearchScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Row(children: [
                                  SvgPicture.asset(
                                    AppImages.searchIcon,
                                    color: Colors.grey,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("بحث",
                                      style: TextStyle(color: Colors.grey)),
                                  const Expanded(child: SizedBox()),
                                  const Icon(
                                    Icons.filter_list_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                ]),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "الاحدث",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor),
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(const FilterBottomSheet(),
                          isScrollControlled: true);
                    },
                    child: Row(
                      children: [
                        const Text(
                          "فلترة",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          AppImages.filterIcon,
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
              posts(controller.posts.posts ?? PostsModel(posts: []), controller)
              // (controller.posts.posts?.posts?.isNotEmpty ?? false) &&
              //         (controller.isLoading == false)
              //     ? posts(controller.posts.posts ?? PostsModel(posts: []),
              //         controller)
              //     : const Center(child: NoDataWidget(title: "لا يوجد ملصقات")),
            ],
          );
        });
  }

  loading() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 3, bottom: 0, right: 0, left: 0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.cardColor),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          CustomLoading(
                            radius: 100,
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLoading(
                                  radius: 10,
                                  height: 10,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomLoading(
                                  radius: 10,
                                  height: 7,
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              CustomLoading(
                                radius: 10,
                                height: 10,
                                width: 40,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomLoading(
                                radius: 10,
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomLoading(
                        radius: 10,
                        height: 13,
                        width: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomLoading(
                        radius: 10,
                        height: 8,
                        width: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 200,
                        child: Stack(
                          children: [
                            CustomLoading(
                              radius: 10,
                              height: 200,
                              width: Get.width,
                            ),
                            Opacity(
                              opacity: .8,
                              child: Image.asset(AppImages.blackLine,
                                  height: 40, width: 45, color: Colors.black12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  posts(PostsModel postsModel, HomeController controller) {
    return GetBuilder<CarouselSliderController>(
        init: CarouselSliderController(),
        builder: (controllerCarousel) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.isLoading
                  ? (postsModel.posts?.length ?? 0) + 1
                  : postsModel.posts?.length,
              itemBuilder: (context, index) {
                if (controller.isLoading && index == postsModel.posts?.length) {
                  return loading();
                }
                return Column(
                  children: [
                    CustomCardInfo(
                      isReview: false,
                      post: postsModel.posts![index],
                    ),
                    if ((index + 1) % 5 == 0)
                      Visibility(
                        visible:
                            controller.getBannerResponse.data?.isNotEmpty ??
                                true,
                        child: Column(
                          children: [
                            CarouselSlider(
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
                              items:
                                  controller.getBannerResponse.data?.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return SizedBox(
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
                                                    color: AppColors.mainColor
                                                        .withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 4,
                                                    offset: const Offset(0,
                                                        1), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: double.infinity,
                                              height: 200,
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: CachedNetworkImage(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          fit: BoxFit.fill,
                                                          imageUrl:
                                                              "${ApiUrl.baseUrl}${i.image}",
                                                          placeholder: (context,
                                                                  url) =>
                                                              const CupertinoActivityIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              SizedBox()))
                                                ],
                                              ),
                                            ),
                                            if (i.link?.isNotEmpty ?? false)
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Opacity(
                                                          opacity: .8,
                                                          child: InkWell(
                                                            onTap: () {
                                                              controllerCarousel
                                                                  .launchUrlFromApi(
                                                                      i.link ??
                                                                          "");
                                                            },
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .mainColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Text(
                                                                    "اضغط هنا",
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .whiteColor),
                                                                  ),
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AnimatedSmoothIndicator(
                              activeIndex: controller.inActiveBox,
                              count: controllerCarousel.sliderList.length,
                              effect: const SlideEffect(
                                dotHeight: 10,
                                activeDotColor: AppColors.mainColor,
                                dotWidth: 10,
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                );
              });
        });
  }
}
