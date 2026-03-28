// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:thimar/constants/assets.dart';
// import 'package:thimar/core/widgets/app_field.dart';
// import 'package:thimar/gen/locale_keys.g.dart';

// import '../utils/extensions.dart';
// import 'app_sheet.dart';
// import 'custom_image.dart';

// class SelectItemSheet extends StatefulWidget {
//   final String title;
//   final List items;
//   final dynamic initItem;
//   final bool withImage, withSearch, isCenter;

//   const SelectItemSheet({
//     super.key,
//     this.withImage = false,
//     this.isCenter = false,
//     required this.title,
//     required this.items,
//     this.initItem,
//     this.withSearch = false,
//   });

//   @override
//   State<SelectItemSheet> createState() => _SelectItemSheetState();
// }

// class _SelectItemSheetState extends State<SelectItemSheet> {
//   late List filteredItems;

//   @override
//   void initState() {
//     for (var item in widget.items) {
//       item.isSelected = false;
//       if (widget.initItem is String) {
//         if (item.name == widget.initItem) {
//           item.isSelected = true;
//         }
//       } else if (widget.initItem is GeneralModel) {
//         if (item.name == (widget.initItem as GeneralModel).name) {
//           item.isSelected = true;
//         }
//       }
//     }
//     filteredItems = widget.items;
//     super.initState();
//   }

//   void _filterItems(String query) {
//     setState(() {
//       filteredItems = widget.items.where((item) {
//         final name = item.name;
//         return name.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomAppSheet(
//       title: widget.title,
//       children: [
//         SizedBox(height: 16.h),
//         if (widget.withSearch)
//           AppField(
//             height: 60.h,
//             hintText: LocaleKeys.searchFor.tr(args: [widget.title]),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: context.primaryColor),
//               borderRadius: BorderRadius.all(Radius.circular(25.r)),
//             ),
//             prefixIcon: IconButton(
//               onPressed: null,
//               icon: CustomImage(Assets.svg.search, height: 20.h, width: 20.h),
//             ),
//             onChanged: _filterItems,
//           ),
//         AnimatedSize(
//           duration: const Duration(milliseconds: 300),
//           child: Column(
//             children: List.generate(filteredItems.length, (index) {
//               final item = filteredItems[index];
//               final isSelected = item.isSelected;
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context, item);
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(bottom: 12.h),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 12.w,
//                     vertical: 10.h,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? context.primaryColor.withValues(alpha: 0.1)
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(25.r),
//                     border: isSelected
//                         ? Border.all(color: context.primaryColor)
//                         : Border.all(color: context.borderColor),
//                   ),
//                   child: Row(
//                     spacing: 8.w,
//                     mainAxisAlignment: widget.isCenter
//                         ? MainAxisAlignment.center
//                         : MainAxisAlignment.start,
//                     children: [
//                       if (widget.withImage)
//                         Container(
//                           padding: EdgeInsets.all(8.r),
//                           decoration: BoxDecoration(
//                             color: context.primaryColor.withValues(alpha: 0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: CustomImage(
//                             filteredItems[index].image,
//                             height: 20.h,
//                             width: 20.h,
//                             color: context.primaryColor,
//                             borderRadius: BorderRadius.circular(4.r),
//                           ),
//                         ),
//                       Text(
//                         filteredItems[index].name,
//                         style: context.mediumText.copyWith(fontSize: 16),
//                       ),
//                       // Icon(
//                       //   isSelected ? Icons.radio_button_checked_sharp : Icons.radio_button_unchecked_sharp,
//                       //   color: isSelected ? context.primaryColor : context.indicatorColor,
//                       //   size: 18.h,
//                       // ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }
