import 'package:url_launcher/url_launcher.dart';
class socialmedia {
  static Future<void> whatsapp(String phnnum) async {
    final Uri _url = Uri.parse(
        'whatsapp://send?phone='+phnnum);//send?phone=9773884079&text=hello!');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  static Future<void> launchWhatsapp() async {
    const url = "https://wa.me/?text=Hey";
    var encoded = Uri.encodeFull(url);
    if (await canLaunch(encoded)) {
      await launch(encoded);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> mail(String email) async {
    Uri mail = Uri.parse(
        "mailto:"+email+"?subject=&body=");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }

  static Future<void> phn(String phnnum) async {
    Uri mail = Uri.parse("tel://"+phnnum);
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }

}