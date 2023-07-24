import 'dart:io';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  void launchPhoneDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';

    await launchUrl(Uri.parse(url));
  }

  void openWhatsApp(String phoneNumber, String defaultText) async {
    final whatsappUrl = 'https://wa.me/${"+962"}$phoneNumber?text=Hi';

    if (await launchUrl(Uri.parse(
      whatsappUrl,
    ))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Could not launch WhatsApp.';
    }
  }
  launchWhatsApp() async {
    int phone = 0785164327;
    var whatsappUrl = "whatsapp://send?phone=$phone";
    await launchUrl(Uri.parse(whatsappUrl));
  }
  void openEmail({String? recipients, String? subject, String? body}) async {
    final emailUri =
        'mailto:$recipients?subject=${Uri.encodeComponent(subject!)}&body=${Uri.encodeComponent(body!)}';

    if (await launchUrl(Uri.parse(emailUri))) {
      await launchUrl(Uri.parse(emailUri));
    } else {
      throw 'Could not launch WhatsApp.';
    }
  }
}
