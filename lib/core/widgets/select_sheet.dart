// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:thimar/core/widgets/select_item.dart';

// import '../../../gen/locale_keys.g.dart';
// import 'flash_helper.dart';

// selectMultiSheet({
//   required BuildContext context,
//   required List list,
//   required String title,
//   required Function callback,
//   dynamic initItem,
//   bool withSearch = false,
//   bool isCenter = false,
//   bool withImage = false,
// }) async {
//   if (list.isEmpty) {
//     FlashHelper.showToast(
//       LocaleKeys.there_are_no_items_to_display_in_this_section.tr(),
//     );
//   } else {
//     final result = await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       elevation: 0,
//       builder: (context) => SelectItemSheet(
//         withSearch: withSearch,
//         title: title,
//         items: list,
//         isCenter: isCenter,
//         initItem: initItem ?? list.first,
//         withImage: withImage,
//       ),
//     );
//     if (result != null) {
//       callback.call(result);
//     }
//   }
// }
