import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/app_colors.dart';

class CustomTextField<T> extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      this.maxLines,
      this.hintText,
      this.validator,
      this.suffixIcon,
      this.title,
      this.autoFocus,
      this.lightLabel,
      this.inputType,
      this.showTitle,
      this.isRequired})
      : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final String? title;
  final bool? isRequired;
  final bool? showTitle;
  final bool? autoFocus;
  final bool? lightLabel;
  final String? suffixIcon;
  final TextInputType? inputType;
  final FormFieldValidator<T>? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (widget.showTitle ?? true)
                    Text(widget.title ?? "",
                        style: TextStyle(
                            fontSize: 15,
                            color: widget.lightLabel == true
                                ? AppColors.whiteColor
                                : AppColors.mainColor,
                            fontWeight: FontWeight.w500)),
                  if (widget.isRequired ?? false)
                    const Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),
              TextFormField(
                maxLines: widget.maxLines,
                autofocus: widget.autoFocus ?? false,
                keyboardType: widget.inputType,
                controller: widget.controller,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  filled: true,
                  fillColor: AppColors.editTextColor,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: SvgPicture.asset(
                      widget.suffixIcon ?? "",
                      height: 2,
                    ),
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(.8), fontSize: 14),
                  helperStyle: TextStyle(color: Colors.black.withOpacity(.5)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    // borderSide:
                    //     BorderSide(color: AppColors.textColor, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
