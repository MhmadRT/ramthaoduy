import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/helper/custom/pickers.dart';

import '../../constant/app_colors.dart';

class CustomDateField extends StatefulWidget {
  final DateTime? initialTime;
  final ValueChanged<DateTime>? onConfirm;
  final String? label;
  final bool? required;
  final bool? lightLabel;

  const CustomDateField(
      {super.key,
      this.initialTime,
      this.onConfirm,
      this.label,
      this.lightLabel,
      this.required});

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  var dotsFormat = DateFormat('dd.MM.yyyy', "en");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Row(
            children: [
              Text(widget.label ?? "",
                  style: TextStyle(
                      fontSize: 15,
                      color: widget.lightLabel == true
                          ? AppColors.whiteColor
                          : AppColors.mainColor,
                      fontWeight: FontWeight.w500)),
              if (widget.required ?? false)
                const Text("*", style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.editTextColor,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                Pickers.showDatePickerMenaMe(
                    initialTime: widget.initialTime ?? DateTime.now(),
                    onConfirm: (value) {
                      widget.onConfirm?.call(value);
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dotsFormat.format(widget.initialTime ?? DateTime.now()),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColors.mainColor,
                    ),
                  ),
                  const Icon(Icons.calendar_month)
                ],
              ),
            )),
      ],
    );
  }
}
