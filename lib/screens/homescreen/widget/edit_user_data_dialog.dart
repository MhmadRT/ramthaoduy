import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ramtha/helper/custom/user_image.dart';
import '../../../constant/app_colors.dart';
import '../../createaccountscreen/create_account_controller.dart';
import '../model/get_user_info.dart';
import '../../../helper/custom/custom_button.dart';
import '../../../helper/custom/custom_drop_down.dart';
import '../../../helper/custom/custom_text_feild.dart';

class EditUserDataDialog extends StatelessWidget {
  const EditUserDataDialog({
    Key? key,
    this.user,
  }) : super(key: key);
  final GetUserInfoResponse? user;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAccountController>(
        init: CreateAccountController(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Column(children: [
                          Stack(
                            children: [
                              controller.imagePath != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(controller.imagePath!.path),
                                            fit: BoxFit.cover,
                                          )))
                                  : UserImage(
                                      userImage: user?.data?.user?.image ?? "",
                                      gender: user?.data?.user?.gender,
                                      radius: 400,
                                      boxFit: BoxFit.cover,
                                      size: 100),
                              Positioned(
                                  bottom: 0,
                                  child: InkWell(
                                    onTap: () {
                                      ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery)
                                          .then((value) {
                                        if (value != null) {
                                          controller.imagePath = value;
                                        }
                                        controller.update();
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.mainColor),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(Icons.edit,
                                            color: AppColors.whiteColor),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            maxLines: 1,
                            controller: controller.editNameController,
                            isRequired: false,
                            suffixSvgIconName: "",
                            hintText: user?.data?.user?.name ?? "بدون اسم",
                            title: "تعديل الأسم",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomDropdown(
                              listItems: controller.cities.cities ?? [],
                              selectedItem: controller.selectedCity,
                              lightLabel: false,
                              isRequired: false,
                              label: 'المحافظة',
                              onSelected: (v) {
                                controller.selectedCity = v;
                                controller.update();
                                controller.getBrigades();
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomDropdown(
                              lightLabel: false,
                              isRequired: false,
                              label: 'الواء',
                              listItems: controller.brigades.brigades ?? [],
                              selectedItem: controller.selectedBrigade,
                              onSelected: (v) {
                                controller.selectedBrigade = v;
                                controller.update();
                                controller.getDistrict();
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomDropdown(
                              lightLabel: false,
                              isRequired: false,
                              label: 'المنطقة',
                              listItems: controller.districts.districts ?? [],
                              selectedItem: controller.selectedDistrict,
                              onSelected: (v) {
                                controller.selectedDistrict = v;
                                controller.update();
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                              color: AppColors.mainColor,
                              title: "حفظ",
                              height: 40,
                              colorTitle: AppColors.whiteColor,
                              pressed: () {
                                controller.updateUserInfo();
                              })
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
