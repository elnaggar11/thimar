import 'package:doctorin/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CustomHtmlItem extends StatelessWidget {
  final String data;
  final TextStyle? style;

  const CustomHtmlItem(this.data, {super.key, this.style});
  @override
  Widget build(BuildContext context) => HtmlWidget(
    data,
    onTapUrl: (url) {
      if (['.JPEG', '.PNG', '.JPG', '.webp'].contains(url)) {
      } else {
        Utils.launchURL(url);
      }
      return true;
    },
    textStyle: style,
  );
}
