import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/flash_helper.dart';

class Utils {
  static String playStoreUrl = "https://play.google.com/store/apps/details?id=";
  static String appStoreUrl = "https://apps.apple.com/app/id=";
  Future openUrl(url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: Platform.isAndroid
          ? LaunchMode.externalNonBrowserApplication
          : LaunchMode.inAppWebView,
    )) {
      throw "Could not open the url";
    }
  }

  static void launchURL(String url) async {
    if (!url.toString().startsWith("https")) {
      url = "https://$url";
    }
    await launchUrl(Uri.parse(url));
  }

  static Future<void> launchGoogleMaps(
    double latitude,
    double longitude,
  ) async {
    final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      FlashHelper.showToast('Could not launch Google Maps');
      throw 'Could not launch Google Maps';
    }
  }

  static void launchWhatsApp(String phone) async {
    if (Platform.isAndroid) {
      launchUrl(
        Uri.parse("https://wa.me/$phone"),
        // mode: LaunchMode.externalNonBrowserApplication
      );
    } else {
      launchUrlString("https://api.whatsapp.com/send?phone=$phone");
    }
  }

  static Future<void> launchAppOnGooglePlay() async {
    final Uri webUrl = Uri.parse(playStoreUrl);
    try {
      if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      await launchUrl(webUrl);
    }
  }

  static Future<void> launchAppStore() async {
    final appStoreLink = Uri.parse(appStoreUrl);

    if (await canLaunchUrl(appStoreLink)) {
      await launchUrl(appStoreLink);
    } else {
      await launchUrl(appStoreLink);
    }
  }

  static String convertDigitsToLatin(String s) {
    final sb = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      switch (s[i]) {
        case '\u0660':
          sb.write('0');
          break;
        case '\u0661':
          sb.write('1');
          break;
        case '\u0662':
          sb.write('2');
          break;
        case '\u0663':
          sb.write('3');
          break;
        case '\u0664':
          sb.write('4');
          break;
        case '\u0665':
          sb.write('5');
          break;
        case '\u0666':
          sb.write('6');
          break;
        case '\u0667':
          sb.write('7');
          break;
        case '\u0668':
          sb.write('8');
          break;
        case '\u0669':
          sb.write('9');
          break;
        default:
          sb.write(s[i]);
          break;
      }
    }
    return sb.toString();
  }

  static void callPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  static void shareUrl(String text) async {
    await Share.share(text);
  }

  static void shareLinkUrl() async {
    await Share.share('$playStoreUrl \n $appStoreUrl');
  }

  static String getFileType(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext)) {
      return 'image';
    } else if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
      return 'video';
    } else {
      return 'file';
    }
  }
}
