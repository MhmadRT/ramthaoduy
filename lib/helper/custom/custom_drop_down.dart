import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';

class CustomDropdown extends StatefulWidget {
  final List<Item> listItems;
  final Item? selectedItem;
  final ValueChanged<Item>? onSelected;

  const CustomDropdown(
      {super.key, required this.listItems, this.selectedItem, this.onSelected});

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.editTextColor),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownButton<Item>(
            menuMaxHeight: Get.height / 3,
            isExpanded: true,
            icon: SvgPicture.asset(
              AppImages.dropDownIcon,
              height: 7,
            ),
            focusColor: const Color(0xff00114F),
            borderRadius: BorderRadius.circular(10),
            underline: const SizedBox(),
            iconEnabledColor: Colors.black,
            dropdownColor: Colors.grey.shade200,
            items: widget.listItems.map<DropdownMenuItem<Item>>((Item value) {
              return DropdownMenuItem<Item>(
                value: value,
                child: Text(
                  value.desc ?? "",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            onChanged: (Item? newValue) {},
            hint: const Text(
              "Please choose a langauage",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}

class Item {
  String? id;
  String? desc;
  String? parentID;
  bool isSelected = false;

  Item({this.id, this.desc, this.parentID});
}
