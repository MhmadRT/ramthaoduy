import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constant/app_images.dart';

class ChangeImageWidget extends StatefulWidget {
  @override
  _ChangeImageWidgetState createState() => _ChangeImageWidgetState();
}

class _ChangeImageWidgetState extends State<ChangeImageWidget> {
  double _imageWidth = 150.0;
  double _imageHeight = 150.0;
  double _imagePosition = 300.0;

  @override
  void initState() {
    super.initState();
    _animateImage(); // Start the animation after 2 seconds (you can change this delay)
  }

  void _animateImage() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _imageWidth = Get.width/1.2; // New width value after 2 seconds
        _imageHeight = Get.height/2.2; // New height value after 2 seconds
        _imagePosition = 0.0; // New position value after 2 seconds
      });
      _showToast('Image animation completed!');
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                  duration: Duration(seconds: 2),
                  width: _imageWidth,
                  height: _imageHeight,
                  margin: EdgeInsets.only(top: _imagePosition),
                  child: SvgPicture.asset(AppImages
                      .logo) // Replace 'image.png' with your image asset path
                  ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontFamily: '',
                  ),
                  child: AnimatedTextKit(
                    displayFullTextOnTap: true,
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                          textAlign: TextAlign.center,
                          'بَشِّرِ الصَّابِرِينَ , الَّذِينَ إِذَا أَصَابَتْهُمْ مُصِيبَةٌ قَالُوا إِنَّا لِلَّهِ وَإِنَّا إِلَيْهِ رَاجِعُونَ , أُوْلَئِكَ عَلَيْهِمْ صَلَوَاتٌ مِنْ رَبِّهِمْ وَرَحْمَةٌ وَأُوْلَئِكَ هُمُ الْمُهْتَدُون صدق الله العظيمَ'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
