import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/screens/mainscreen/main_controller.dart';
import 'package:ramtha/screens/post_detealis/post_controller.dart';
import '../../constant/app_images.dart';
import '../../constant/const_var.dart';
import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_text_feild.dart';
import '../../helper/custom/location_card.dart';
import '../../helper/custom/user_image.dart';
import '../homescreen/model/comments_response.dart';
import '../homescreen/model/posts_response.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 80,
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
                            child: const Icon(Icons.arrow_back_ios,
                                color: AppColors.whiteColor, size: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "تفاصيل الوفاة",
                              style: TextStyle(
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    post.deadName ?? "",
                                    style: const TextStyle(
                                        color: AppColors.mainColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  ConstVars.format.format(post.createdDate!),
                                  style: TextStyle(
                                    color: AppColors.mainColor.withOpacity(.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              post.buryDescription ?? "",
                              maxLines: 3,
                              style: const TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: Get.width,
                              height: 200,
                              child: Stack(
                                children: [
                                  UserImage(
                                      radius: 20,
                                      userImage: post.image,
                                      gender: post.gender,
                                      size: Get.width),
                                  Opacity(
                                    opacity: .8,
                                    child: Image.asset(AppImages.blackLine,
                                        height: 40, width: 45),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: AppColors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'الموقع',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            LocationMapWidget(
                                lat: double.parse(post.latatude ?? '0'),
                                lng: double.parse(post.longitude ?? '0')),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColors.mainColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'رقم الهاتف',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    Get.find<PostController>()
                                        .launchPhoneDialer(
                                            post.phoneNumber.toString());
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        post.phoneNumber ?? "",
                                        style: const TextStyle(
                                            color: AppColors.blueButtonColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.messenger_outline,
                                        color: AppColors.mainColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'ارسال رسالة SMS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    String? name = Get.find<MainController>()
                                        .userInfoResponse
                                        ?.data
                                        ?.user
                                        ?.name;
                                    Get.find<PostController>().openSms(
                                        post.phoneNumber.toString(),
                                        " عظم الله اجركم ورحم ميتكم واسكنه فسيح جناته $name");
                                  },
                                  child: const Column(
                                    children: [
                                      Text(
                                        "اضغط هنا",
                                        style: TextStyle(
                                            color: AppColors.blueButtonColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.messenger_outline,
                                        color: AppColors.mainColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'ارسال رسالة WhatsApp',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    Get.find<PostController>().openWhatsApp(
                                        post.phoneNumber.toString(),
                                        "عظم الله اجركم ورحم ميتكم واسكنه فسيح جناته");
                                  },
                                  child: const Column(
                                    children: [
                                      Text(
                                        "اضغط هنا",
                                        style: TextStyle(
                                            color: AppColors.blueButtonColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.person,
                                          color: AppColors.mainColor),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'اسم صاحب الرقم',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    post.nameOfRequester ?? "",
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: AppColors.mainColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppImages.commentIcon,
                                  height: 17,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'التعليقات',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GetBuilder<PostController>(
                                init: PostController(post),
                                builder: (controller) {
                                  return controller.isLoadingComment
                                      ? loading()
                                      : commentsWidget(
                                          controller.commentPosts, controller);
                                }),
                            GetBuilder<PostController>(
                                init: PostController(post),
                                builder: (controller) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: CustomTextField(
                                        showTitle: false,
                                        hintText: 'أضف تعليق',
                                        maxLines: 1,
                                        controller: controller.comment,
                                        onchange: (v) {
                                          controller.update();
                                        },
                                      )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap:
                                            controller.comment.text.isNotEmpty
                                                ? () {
                                                    controller.addComment();
                                                  }
                                                : null,
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: controller
                                                      .comment.text.isNotEmpty
                                                  ? AppColors.mainColor
                                                  : AppColors.mainColor
                                                      .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Icon(
                                              Icons.send,
                                              color: AppColors.whiteColor,
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  loading() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLoading(
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomLoading(
                            height: 10,
                            width: 100,
                          ),
                          Expanded(child: SizedBox()),
                          CustomLoading(height: 7, width: 20),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomLoading(
                            height: 5,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          CustomLoading(
                            height: 5,
                            width: 40,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          CustomLoading(
                            height: 5,
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  commentsWidget(
      CommentsResponse? commentsResponse, PostController controller) {
    return (commentsResponse?.data?.comments?.isEmpty ?? true)
        ? const Center(child: Text('لا يوجد تعليقات'))
        : ListView.builder(
            controller: controller.scrollController,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: commentsResponse?.data?.comments?.length,
            itemBuilder: (context, index) {
              var comment = commentsResponse?.data?.comments?[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  dragStartBehavior: DragStartBehavior.start,
                  background: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.red,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.clear,
                            color: AppColors.whiteColor,
                          ),
                          Icon(
                            Icons.clear,
                            color: AppColors.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  key: Key(DateTime.now().toIso8601String()),
                  onDismissed: (_) =>
                      controller.deleteComment(comment?.id.toString()),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.cardColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserImage(
                              size: 30,
                              radius: 50,
                              gender: comment?.username,
                              userImage: comment?.username),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      comment?.username ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    )),
                                    Column(
                                      children: [
                                        Text(
                                          comment?.createdAt ?? "",
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(comment?.content ?? "")),
                                  ],
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
}
