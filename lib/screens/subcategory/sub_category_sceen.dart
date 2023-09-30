import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/screens/reviewsscreen/review_controller.dart';
import 'package:ramtha/screens/subcategory/sub_category_controller.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_card_info.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/no_data_widget.dart';
import '../../network/api_urls.dart';
import '../homescreen/model/posts_response.dart';
import '../post_detealis/post_detealis_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoryController>(
        init: SubCategoryController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 85,
                      decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 45,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_back_ios,
                                        color: AppColors.whiteColor, size: 15),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    title ?? "",
                                    style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              CustomDropdown(
                                  isRequired: false,
                                  label: 'المنطقة',
                                  listItems:
                                      controller.districts.districts ?? [],
                                  selectedItem: controller.selectedDistrict,
                                  onSelected: (v) async {
                                    controller.selectedDistrict = v;
                                    await controller.serviceClassification();
                                    controller.update();

                                    controller.update();
                                  }),
                              if (controller.isLoading) loading(),
                              ((controller
                                                  .getResponse
                                                  .data
                                                  ?.serviceClassification
                                                  ?.length ??
                                              0) >
                                          0 &&
                                      controller.isLoading == false)
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: controller.getResponse.data
                                          ?.serviceClassification?.length,
                                      itemBuilder: (context, index2) {
                                        var data = controller.getResponse.data
                                            ?.serviceClassification?[index2];
                                        controller.idSelectedFromSub = data?.id;
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColors.categoryColor,
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: CachedNetworkImage(
                                                    width: 100,
                                                    imageUrl: ApiUrl.baseUrl +
                                                        (data?.name ?? ""),
                                                    fit: BoxFit.cover,
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        const Center(
                                                            child:
                                                                CupertinoActivityIndicator()),
                                                    errorWidget: (context, url, error) => Center(
                                                        child: Container(
                                                            width: Get.width,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade100,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: const Icon(
                                                                Icons.error))),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15,
                                                            horizontal: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                  data?.name ??
                                                                      "",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                  data?.address ??
                                                                      "",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: ()async {
                                                     await controller
                                                        .whenClickPhoneNumber(index: index2);
                                                    controller
                                                        .launchPhoneDialer(
                                                            data?.phone ?? "");
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text("اتصال",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .green2,
                                                                    fontSize:
                                                                        14)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : Visibility(
                                      visible: controller.isLoading == false,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 100,
                                          ),
                                          NoDataWidget(
                                            title:
                                                " لا يوجد في هذه المنطقة $title ",
                                          ),
                                        ],
                                      ),
                                    ),
                              // loading(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  loading() {
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.categoryColor,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                            color: Colors.grey.shade100,
                            child: CustomLoading(
                              height: 100,
                              width: 100,
                              radius: 8,
                            )),
                      ),
                      const Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomLoading(
                                    height: 11,
                                    width: 200,
                                    radius: 8,
                                  )),
                                ],
                              ),
                              Row(
                                children: [
                                  CustomLoading(
                                    height: 8,
                                    width: 100,
                                    radius: 8,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CustomLoading(
                                  height: 8,
                                  width: 50,
                                  radius: 8,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
