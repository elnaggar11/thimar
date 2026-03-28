// import 'package:flutter/material.dart';
// import 'package:thimar/core/utils/extensions.dart';
// import 'package:thimar/core/widgets/custom_image.dart';

// class RatingBarWidget extends StatelessWidget {
//   final num rate;
//   final double itemSize;
//   final dynamic onRateUpdate;
//   const RatingBarWidget({
//     required this.rate,
//     super.key,
//     this.itemSize = 13,
//     this.onRateUpdate,
//   });

//   @override
//   Widget build(BuildContext context) => RatingBar.builder(
//     initialRating: rate.toDouble(),
//     allowHalfRating: true,
//     itemSize: itemSize,
//     itemPadding: const EdgeInsets.symmetric(horizontal: 2),
//     ignoreGestures: onRateUpdate == null,
//     unratedColor: context.borderColor,
//     itemBuilder: (context, _) => CustomImage(
//       Assets.svg.star,
//       width: itemSize,
//       height: itemSize,
//       color: Colors.amber,
//     ),
//     onRatingUpdate: onRateUpdate ?? (rate) {},
//   );
// }
