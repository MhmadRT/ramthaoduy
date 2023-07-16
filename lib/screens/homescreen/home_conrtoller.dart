import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/screens/homescreen/home_repository.dart';
import 'package:ramtha/screens/homescreen/model/get_banner_response.dart';
import 'package:ramtha/screens/homescreen/model/posts_request.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:flutter/material.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/custom/custom_loading.dart';
import '../createaccountscreen/create_account_repository.dart';
import '../createaccountscreen/models/brigades.dart';
import '../createaccountscreen/models/cities.dart';
import '../createaccountscreen/models/districts.dart';
import 'model/get_number_readed_notification.dart';

class HomeController extends GetxController {
  bool allPost = true;
  bool isVisibleDate = false;
  int inActiveBox = 0;
  bool isVisibleDrop = false;
  bool isVisibleGender = false;
  HomeRepository repository = HomeRepository();
  GetNumberNotReaded getNumberNotReaded = GetNumberNotReaded();
  CreateAccountRepository createAccountRepository = CreateAccountRepository();
  PostsResponse posts = PostsResponse(posts: PostsModel(posts: []));
  GetBannerResponse getBannerResponse = GetBannerResponse(data: []);
  bool isLoading = true;
  late ScrollController scrollController;
  DateTime fromDate = DateTime.now();
  int selectSexIndex = 1;
  Cities cities = Cities(cities: []);
  Item selectedCity = Item(name: 'أختر المحافظة',id: '1');
  Districts districts = Districts(districts: []);
  Item selectedDistrict = Item(name: 'أختر المنطقة',);
  Brigades brigades = Brigades(brigades: []);
  Item selectedBrigade = Item(name: 'أختر الواء',id: '1');
  var formatter = DateFormat('dd/MM/yyyy');
  var formatterDots = DateFormat('dd.MM.yyyy');
  int pageNumber = 1;
  int countPerPage = 10;

  bool isMoreLoad = false;

  getPosts() async {
    isLoading = true;
    update();
    PostsRequest postsRequest = PostsRequest(
      page: pageNumber.toString(),
      cityId: isVisibleDrop ? selectedCity.id : null,
      fromDate: isVisibleDate ? fromDate.toIso8601String() : null,
      gender: isVisibleGender ? selectSexIndex.toString() : null,
      toDate: isVisibleDate ? fromDate.toIso8601String() : null,
    );

    PostsResponse currentPosts =
        await repository.getPosts(postsRequest.toJson());
    isMoreLoad = currentPosts.posts?.posts?.length == countPerPage;
    pageNumber++;
    posts.posts?.posts?.addAll(currentPosts.posts?.posts ?? []);
    isLoading = false;
    update();
  }

  getBanners() async {
    // isLoading = true;
    update();

    getBannerResponse = await repository.getBanner({});
    // isLoading = false;
    update();
  }

  getNumberNotifications() async {
    update();
    getNumberNotReaded = await repository.getNumberNotifications({});
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

  void _scrollListener() {
    if ((scrollController.position.extentAfter) < 250 && isMoreLoad) {
      isMoreLoad = false;
      getPosts();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    scrollController = ScrollController()..addListener(_scrollListener);
    getNumberNotifications();
    getPosts();
    getBanners();

    super.onInit();
  }
}
