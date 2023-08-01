import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';

import '../../network/api_urls.dart';

class UserImage extends StatelessWidget {
  final String? userImage;
  final String? gender;
  final double? size;
  final double? radius;
  final BoxFit? boxFit;
  final bool? isComment;

  const UserImage(
      {Key? key,
      this.gender,
      this.userImage,
      this.isComment,
      this.size,
      this.radius,
      this.boxFit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Container(
        color: Colors.grey.shade100,
        child: SizedBox(
          height: size,
          width: size,
          child: CachedNetworkImage(
            imageUrl: ApiUrl.baseUrl + (userImage ?? ""),
            fit: boxFit,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: isComment ?? false
                        ? SvgPicture.asset(
                            color: AppColors.mainColor.withOpacity(.65),
                            // fit: BoxFit.cover,
                            gender == "ذكر"
                                ? AppImages.maleSvg
                                : AppImages.femaleSvg,
                            height: size,
                            width: size,
                          )
                        : const CupertinoActivityIndicator()),
            errorWidget: (context, url, error) => Center(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: SvgPicture.asset(
                color: AppColors.mainColor.withOpacity(.65),
                // fit: BoxFit.cover,
                gender == "ذكر" ? AppImages.maleSvg : AppImages.femaleSvg,
                height: size,
                width: size,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
