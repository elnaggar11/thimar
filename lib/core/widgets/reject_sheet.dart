// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:thimar/core/utils/extensions.dart';
// import 'package:thimar/core/widgets/app_field.dart';

// import '../../gen/locale_keys.g.dart';
// import 'app_btn.dart';
// import 'app_sheet.dart';
// import 'fade_in_slide.dart';

// class RejectSheet extends StatefulWidget {
//   final List<String> reasons;
//   final Function(String reason, String? otherReason) onConfirm;

//   const RejectSheet({
//     super.key,
//     required this.reasons,
//     required this.onConfirm,
//   });

//   @override
//   State<RejectSheet> createState() => _RejectSheetState();
// }

// class _RejectSheetState extends State<RejectSheet> {
//   String selectedReason = '';
//   final TextEditingController textController = TextEditingController();
//   bool isReason = false, isAnotherReason = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.reasons.isNotEmpty) {
//       selectedReason = widget.reasons.first;
//     }
//   }

//   @override
//   void dispose() {
//     textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomAppSheet(
//       isClose: false,
//       title: isReason
//           ? LocaleKeys.cancellationReason.tr()
//           : LocaleKeys.cancelAppointment.tr(),
//       children: [
//         Text(
//           LocaleKeys.areYouSureYouWantToRejectThisAppointment.tr(),
//           style: context.semiboldText,
//         ),
//         AnimatedCrossFade(
//           duration: const Duration(milliseconds: 500),
//           crossFadeState: isReason
//               ? CrossFadeState.showSecond
//               : CrossFadeState.showFirst,
//           sizeCurve: Curves.easeInOutQuart,
//           firstCurve: Curves.easeInOutQuart,
//           secondCurve: Curves.easeInOutQuart,
//           firstChild: FadeInSlide(
//             duration: 0.4,
//             direction: FadeSlideDirection.ltr,
//             child: Row(
//               spacing: 10.w,
//               children: [
//                 Expanded(
//                   child: CustomButton(
//                     onTap: () => Navigator.pop(context),
//                     title: LocaleKeys.no.tr(),
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomButton(
//                     onTap: () {
//                       setState(() {
//                         isReason = true;
//                       });
//                     },
//                     textColor: context.errorColor,
//                     backgroundColor: context.errorColor.withValues(alpha: 0.05),
//                     title: LocaleKeys.yesCancel.tr(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           secondChild: Column(
//             spacing: 10.h,
//             children: [
//               if (isAnotherReason)
//                 Row(
//                   spacing: 10.w,
//                   children: [
//                     InkWell(
//                       borderRadius: BorderRadius.circular(999),
//                       onTap: () => setState(() {
//                         isAnotherReason = false;
//                         if (widget.reasons.isNotEmpty) {
//                           selectedReason = widget.reasons.first;
//                         }
//                       }),
//                       child: CircleAvatar(
//                         backgroundColor: context.borderColor.withValues(
//                           alpha: 0.2,
//                         ),
//                         child: Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           size: 20.r,
//                           color: context.hintColor,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         LocaleKeys.anotherReason.tr(),
//                         style: context.semiboldText,
//                       ),
//                     ),
//                   ],
//                 ),
//               if (isAnotherReason)
//                 FadeInSlide(
//                   duration: 0.3,
//                   direction: FadeSlideDirection.ltr,
//                   child: AppField(
//                     controller: textController,
//                     hintText: LocaleKeys.problemWithApp.tr(),
//                     maxLines: 4,
//                   ),
//                 )
//               else
//                 FadeInSlide(
//                   duration: 0.3,
//                   direction: FadeSlideDirection.ltr,
//                   child: Column(
//                     children: [
//                       Wrap(
//                         spacing: 5.w,
//                         runSpacing: 5.h,

//                         children: List.generate(
//                           widget.reasons.length,
//                           (index) => ReasonItem(
//                             reason: widget.reasons[index],
//                             isSelected: selectedReason == widget.reasons[index],
//                             onTap: () {
//                               setState(() {
//                                 selectedReason = widget.reasons[index];
//                                 if (widget.reasons[index] ==
//                                     LocaleKeys.anotherReason) {
//                                   isAnotherReason = true;
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => setState(() {
//                           isAnotherReason = true;
//                           if (widget.reasons.isNotEmpty) {
//                             selectedReason = widget.reasons.first;
//                           }
//                         }),
//                         child: FadeInSlide(
//                           duration: 0.3,
//                           direction: FadeSlideDirection.ltr,
//                           child: Container(
//                             margin: EdgeInsets.only(top: 10.h),
//                             padding: EdgeInsets.symmetric(
//                               vertical: 10.h,
//                               horizontal: 16.w,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12.r),
//                               color: context.borderColor.withValues(alpha: 0.5),
//                             ),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   LocaleKeys.anotherReason.tr(),
//                                   style: context.semiboldText,
//                                 ),
//                                 const Spacer(),
//                                 Icon(
//                                   Icons.arrow_forward,
//                                   color: context.hintColor,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               FadeInSlide(
//                 duration: 0.8,
//                 direction: FadeSlideDirection.ltr,
//                 child: CustomButton(
//                   onTap: () {
//                     widget.onConfirm(selectedReason, textController.text);
//                     Navigator.pop(context);
//                   },
//                   textColor: context.errorColor,
//                   backgroundColor: context.errorColor.withValues(alpha: 0.05),
//                   title: LocaleKeys.confirmCancellation.tr(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
