import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramtha/constant/app_images.dart';

import '../../network/api_urls.dart';

class UserImage extends StatelessWidget {
  final String? userImage;
  final String? gender;
  final double? size;
  final double? radius;

  const UserImage({Key? key, this.gender, this.userImage, this.size,this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius??0),
      child: SizedBox(
        height: size,
        width: size,
        child: CachedNetworkImage(
          imageUrl: ApiUrl.baseUrl + (userImage ?? ""),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child: Image.asset(
                gender == "ذكر" ? AppImages.male : AppImages.female,
                height: size,
                width: size,
              )),
          errorWidget: (context, url, error) => Center(
              child: Image.asset(
            gender == "ذكر" ? AppImages.male : AppImages.female,
            height: size,
            width: size,
          )),
        ),
      ),
    );
  }
}
