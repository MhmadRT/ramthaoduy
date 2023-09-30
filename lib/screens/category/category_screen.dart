import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import '../../network/api_urls.dart';
import '../subcategory/sub_category_sceen.dart';
import 'category_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.getMainCategory.data?.category?.length,
              itemBuilder: (context, index1) {
                var data = controller.getMainCategory.data?.category?[index1];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(data?.title ?? "",
                            style: const TextStyle(
                                fontSize: 17,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: Get.height / 4,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data?.subcategory?.length,
                          itemBuilder: (context, index2) {
                            var item = data?.subcategory?[index2];
                            controller.idCategory = item?.id;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => SubCategoryScreen(
                                        title: item?.subcategoryTilte ?? "",
                                      ));
                                },
                                child: Container(
                                  height: Get.height / 5,
                                  width: Get.width / 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.categoryColor,
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        child: CachedNetworkImage(
                                          height: Get.height / 6.5,
                                          width: Get.width / 3,
                                          imageUrl: ApiUrl.baseUrl +
                                              (item?.image ?? ""),
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const Center(
                                                  child:
                                                      CupertinoActivityIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                                  child: Container(
                                                      width: Get.width,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: const Icon(
                                                          Icons.error))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    data?.title ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.mainColor,
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      item?.subcategoryTilte ??
                                                          "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: AppColors
                                                              .mainColor,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
