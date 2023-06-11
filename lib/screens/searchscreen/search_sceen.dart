import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/screens/searchscreen/search_controller.dart';
import '../../helper/custom/custom_text_feild.dart';

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
                      isRequired: false,autoFocus: true,
                      showTitle: false,
                      suffixIcon: "",
                      inputType: TextInputType.text,
                      hintText: "اكتب هنا ...",
                      title: "البحث",
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(AppImages.searchIcon, height: 20),
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }
}
