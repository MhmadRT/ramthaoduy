import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/helper/custom/custom_button.dart';

class CustomReviewCard extends StatefulWidget {
  String? period;
  String? sex = "1";
  String? image;
  String? name;
  String? date;
  String? age;
  String? town;

  CustomReviewCard(
      {super.key,
      this.period,
      this.sex,
      this.image,
      this.name,
      this.date,
      this.age,
      this.town});

  @override
  State<CustomReviewCard> createState() => _CustomCardInfoState();
}

class _CustomCardInfoState extends State<CustomReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey.shade50),
              BoxShadow(color: Colors.grey.shade100),
              BoxShadow(color: Colors.grey.shade200),
              BoxShadow(color: Colors.grey.shade300),
              BoxShadow(color: Colors.grey.shade400),
            ],
            color: AppColors.infoCardColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 0, right: 0, left: 0),
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width / 2.5,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child:
                                    (widget.image == null || widget.image == "")
                                        ? widget.sex == "1"
                                            ? Image.asset(
                                                fit: BoxFit.fitHeight,
                                                height: 150,
                                                AppImages.male)
                                            : Image.asset(
                                                fit: BoxFit.fitHeight,
                                                height: 150,
                                                AppImages.female)
                                        : Image.network(
                                            fit: BoxFit.fitHeight,
                                            height: 150,
                                            widget.image ?? "")),
                            Opacity(
                              opacity: .8,
                              child: Image.asset(AppImages.blackLine,
                                  height: 40, width: 45),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.period ?? "",
                                    style: TextStyle(
                                      color:
                                          AppColors.mainColor.withOpacity(.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.name ?? "",
                                style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.date ?? "",
                                style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.age ?? "",
                                style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.town ?? "",
                                style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                          color: AppColors.red,
                          title: "رفض",
                          colorTitle: AppColors.whiteColor,
                          height: 30,
                          pressed: () {},
                          width: Get.width / 2.5),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomButton(
                          color: AppColors.mainColor,
                          title: "قبول",
                          colorTitle: AppColors.whiteColor,
                          height: 30,
                          pressed: () {},
                          width: Get.width / 2.5),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
