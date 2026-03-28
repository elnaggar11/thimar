// import 'package:doctorin/core/utils/enums.dart';
// import 'package:doctorin/core/utils/extensions.dart';
// import 'package:doctorin/core/widgets/custom_image.dart';
// import 'package:doctorin/gen/assets.gen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class BookingTypeContainer extends StatefulWidget {
//   final BookingType type;
//   const BookingTypeContainer({super.key, required this.type});

//   @override
//   State<BookingTypeContainer> createState() => _BookingTypeContainerState();
// }

// class _BookingTypeContainerState extends State<BookingTypeContainer> {
//   String _bookingTypeText(BookingType type) {
//     switch (type) {
//       case BookingType.instant:
//         return 'Instant';
//       case BookingType.scheduled:
//         return 'Scheduled';
//       case BookingType.standard:
//         return 'Standard';
//     }
//   }

//   String _bookingTypeImage(BookingType type) {
//     switch (type) {
//       case BookingType.instant:
//         return Assets.svg.instant;
//       case BookingType.scheduled:
//         return Assets.svg.scedualed;
//       case BookingType.standard:
//         return Assets.svg.standard;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
//       decoration: BoxDecoration(
//         color: context.primaryColorLight,
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: Row(
//         spacing: 2.w,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 25.h,
//             padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
//             decoration: BoxDecoration(
//               color: widget.type == BookingType.instant
//                   ? context.errorColor.withValues(alpha: 0.1)
//                   : null,
//               shape: BoxShape.circle,
//             ),
//             constraints: BoxConstraints(maxWidth: 25.w, maxHeight: 25.h),
//             child: CustomImage(
//               _bookingTypeImage(widget.type),
//               height: 20.h,
//               width: 20.w,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Text(_bookingTypeText(widget.type), style: context.semiboldText),
//         ],
//       ),
//     );
//   }
// }
