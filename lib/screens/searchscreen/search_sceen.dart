import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/helper/custom/no_data_widget.dart';
import 'package:ramtha/screens/searchscreen/search_controller.dart';
import '../../helper/custom/custom_card_info.dart';
import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_text_feild.dart';
import '../homescreen/model/posts_response.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
        init: SearchScreenController(),
        builder: (controller) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.searchController,
                      isRequired: false,
                      autoFocus: true,
                      showTitle: false,
                      onchange: (v) {
                        controller.update();
                      },
                      suffixSvgIconName: "",
                      inputType: TextInputType.text,
                      hintText: "اكتب هنا ...",
                      title: "البحث",
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: controller.searchController.text.isNotEmpty
                        ? () {
                            controller.getPostsFromSearch();
                          }
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                          color: controller.searchController.text.isNotEmpty
                              ? AppColors.mainColor
                              : AppColors.mainColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            SvgPicture.asset(AppImages.searchIcon, height: 20),
                      ),
                    ),
                  )
                ],
              ),
              if (controller.isLoading) loading(),
              posts(
                  controller.posts?.posts ?? PostsModel(posts: []), controller),
            ],
          );
        });
  }

  loading() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: CustomLoading(
              height: 120,
              width: Get.width,
            ),
          );
        });
  }

  posts(PostsModel postsModel, SearchScreenController controller) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: postsModel.posts?.length,
        itemBuilder: (context, index) {
          return (postsModel.posts?.length??0)>0?CustomCardInfo(
            isReview: false,
            post: postsModel.posts![index],
          ):const NoDataWidget();
        });
  }
}
