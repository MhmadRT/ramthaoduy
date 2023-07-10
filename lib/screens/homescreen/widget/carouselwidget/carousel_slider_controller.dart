import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselSliderController extends GetxController {
  int inActiveBox = 0;
  List<SliderInfo> sliderList = [
    SliderInfo(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQp2Am52dZfl0iipUaiFAYPEu40EkTjAOFIFDkMaRgmV89Z6AzVUi7Xb65Rm9p40dzVss0&usqp=CAU",
    ),
    SliderInfo(
        image:
            "https://scontent.famm2-3.fna.fbcdn.net/v/t39.30808-6/308493716_502826328519185_4320516057220197970_n.jpg?stp=dst-jpg_s960x960&_nc_cat=109&ccb=1-7&_nc_sid=e3f864&_nc_ohc=RipeYe-Lh3UAX_xJzr2&_nc_ht=scontent.famm2-3.fna&oh=00_AfDhCuHE26aol420_G96WTEf3i_5LNlUgy_DoKTeUDAXsg&oe=64AFBBB6",
        url:
            "https://www.facebook.com/photo/?fbid=502826335185851&set=a.488624223272729"),
  ];

  void launchUrlFromApi(String url) async {
      await launchUrl(Uri.parse(url));
  }
}

class SliderInfo {
  final String? url;
  final String? image;

  SliderInfo({this.url, this.image});
}
