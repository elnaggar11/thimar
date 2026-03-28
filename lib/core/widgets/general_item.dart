// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:thimar/core/utils/extensions.dart';

// class GeneralItem extends StatelessWidget {
//   final GeneralModel item;
//   final void Function()? onTap;
//   final bool isSelected;
//   const GeneralItem({
//     super.key,
//     required this.item,
//     this.onTap,
//     required this.isSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: context.w,
//         padding: EdgeInsets.all(16.r),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? context.primaryColor.withValues(alpha: 0.04)
//               : context.scaffoldBackgroundColor,
//           borderRadius: BorderRadius.circular(16.r),
//           border: isSelected
//               ? Border.all(color: context.primaryColor)
//               : Border.all(color: context.borderColor),
//         ),
//         child: Text(
//           item.name,
//           style: context.mediumText.copyWith(fontSize: 16),
//         ).withPadding(vertical: 5.r),
//       ),
//     );
//   }
// }
