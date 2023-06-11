import 'package:flutter/material.dart';
import 'package:ramtha/helper/custom/custom_card_info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCardInfo(
          age: "50 سنة",
          date: "2022.08.22",
          image:
          "https://www.sayidaty.net/sites/default/files/styles/900_scale/public/2019/12/03/6145006-1029464460.jpg",
          name: "احمد مرتضى ابو حمادة",
          period: "منذ 5 ساعات",
          town: "الرمثا",
        ),
        CustomCardInfo(
          age: "50 سنة",
          date: "2022.08.22",
          image:
          "https://saudia9.com/wp-content/uploads/2021/05/%D8%B5%D9%88%D8%B1-%D8%A7%D8%B4%D8%AE%D8%A7%D8%B5-5.jpg",
          name: "احمد مرتضى ابو حمادة",
          period: "منذ 5 ساعات",
          town: "الرمثا",
        ),
        CustomCardInfo(
          age: "50 سنة",
          date: "2022.08.22",
          image: "",
          sex: "1",
          name: "احمد مرتضى ابو حمادة",
          period: "منذ 5 ساعات",
          town: "الرمثا",
        ),

        CustomCardInfo(
          age: "50 سنة",
          date: "2022.08.22",
          image: "",
          sex: "2",
          name: "احمد مرتضى ابو حمادة",
          period: "منذ 5 ساعات",
          town: "الرمثا",
        ),

      ],
    );
  }
}
