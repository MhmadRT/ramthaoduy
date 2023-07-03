import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_drop_down.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/helper/local_storage_helper.dart';

import '../../screens/createaccountscreen/create_account_repository.dart';
import '../../screens/createaccountscreen/models/cities.dart';
import '../../screens/createaccountscreen/models/districts.dart';

class SubscribeDialog extends StatefulWidget {
  const SubscribeDialog({super.key});

  @override
  State<SubscribeDialog> createState() => _SubscribeDialogState();
}

class _SubscribeDialogState extends State<SubscribeDialog> {
  Item selectedCity = Item(
    name: 'أختر المحافظة',
    id: '4',
  );
  Districts districts = Districts(districts: []);
  Item selectedDistrict = Item(name: 'أختر المنطقة');
  Item selectedBrigade = Item(name: 'أختر الواء', id: '2');
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((value) => getDistrict());
    super.initState();
  }

  getDistrict() async {
    CreateAccountRepository repository = CreateAccountRepository();
    selectedDistrict = Item(name: 'أختر المنطقة');
    districts = Districts(districts: []);
    districts =
        await repository.getDistricts(brigadeId: selectedBrigade.id ?? "");
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      insetPadding: EdgeInsets.all(20),
      child: SizedBox(
        height: Get.height/1.5,
        width: Get.width,
        child: Column(
          children: [
            isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : ListView.builder(
              padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: districts.districts?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return topicWidget(districts.districts![index]);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget topicWidget(Item item) {
    return FutureBuilder(
      future: LocalStorageHelper.topicIsSubscribed(item.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListTile(
            title: Text(item.name ?? ""),
            leading: Checkbox(
              value: snapshot.data,
              onChanged: (v) async {
                loading();
                await LocalStorageHelper.clickTopic(item.id ?? "");
                closeLoading();
                setState(() {});
              },
            ),
          );
        }
        return Checkbox(
          value: false,
          onChanged: (v) async {
            setState(() {});
          },
        );
      },
    );
  }
}
