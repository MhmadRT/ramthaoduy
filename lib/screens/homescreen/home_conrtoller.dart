import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/screens/homescreen/home_repository.dart';
import 'package:ramtha/screens/homescreen/model/posts_request.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:flutter/material.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/custom/custom_loading.dart';
import '../createaccountscreen/create_account_repository.dart';
import '../createaccountscreen/models/brigades.dart';
import '../createaccountscreen/models/cities.dart';
import '../createaccountscreen/models/districts.dart';

class HomeController extends GetxController {
  bool allPost = true;
  bool isVisibleDate = false;
  bool isVisibleDrop = false;
  bool isVisibleGender = false;
  HomeRepository repository = HomeRepository();
  CreateAccountRepository createAccountRepository = CreateAccountRepository();
  PostsResponse? posts;
  bool isLoading = true;
  ScrollController? scrollController;
  DateTime fromDate = DateTime.now();
  int selectSexIndex = 1;
  Cities cities = Cities(cities: []);
  Item selectedCity = Item(name: 'أختر المحافظة');
  Districts districts = Districts(districts: []);
  Item selectedDistrict = Item(name: 'أختر المنطقة');
  Brigades brigades = Brigades(brigades: []);
  Item selectedBrigade = Item(name: 'أختر الواء');
  var formatter = DateFormat('dd/MM/yyyy');
  var formatterDots = DateFormat('dd.MM.yyyy');

  getPosts() async {
    isLoading = true;
    update();
    PostsRequest postsRequest = PostsRequest(
      cityId: isVisibleDrop ? selectedCity.id : null,
      fromDate: isVisibleDate ? fromDate.toIso8601String() : null,
      gender: isVisibleGender ? selectSexIndex.toString() : null,
      toDate: isVisibleDate ? fromDate.toIso8601String() : null,
    );

    posts = await repository.getPosts(postsRequest.toJson());
    isLoading = false;
    update();
  }

  getCities() async {
    loading();
    selectedCity = Item(name: 'أختر المحافظة');
    selectedBrigade = Item(name: 'أختر الواء');
    selectedDistrict = Item(name: 'أختر المنطقة');
    cities = Cities(cities: []);
    cities = await createAccountRepository.getCities();
    update();
    closeLoading();
  }

  getBrigades() async {
    loading();
    selectedBrigade = Item(name: 'أختر الواء');
    selectedDistrict = Item(name: 'أختر المنطقة');
    brigades = Brigades(brigades: []);
    brigades = await createAccountRepository.getBrigades(
        cityId: selectedCity.id ?? "");
    update();
    closeLoading();
  }

  getDistrict() async {
    loading();
    selectedDistrict = Item(name: 'أختر المنطقة');
    districts = Districts(districts: []);
    districts = await createAccountRepository.getDistricts(
        brigadeId: selectedBrigade.id ?? "");
    update();
    closeLoading();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getPosts();
    super.onInit();
  }
}
