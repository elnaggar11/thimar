// import 'dart:developer';
// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:madar_24/features/create_service/cubit/create_service_cubit.dart';
// import 'package:madar_24/gen/locale_keys.g.dart';

// import 'base.dart';

// class ServicesFormModel extends Model {
//   late final String key;
//   late final String type;
//   late final bool isRequired;
//   late final int sortOrder;
//   late final List<String> options;
//   late final String validation;
//   late final String label;
//   late final String? placeholder;
//   late final String helpText;

//   final controller = TextEditingController();
//   CreateRequestAttachment? image;
//   LatLng? latLng;
//   String? location;
//   String? selectedOption;
//   List<String>? multiSelectedOption;
//   DateTime? selectedDate;

//   File? file;
//   Map<String, dynamic> get value {
// if (type == "checkbox") {
//   final Map<String, dynamic> payload = {};
//   for (var i = 0; i < (multiSelectedOption?.length ?? 0); i++) {
//     payload.addAll({"$key[$i]": multiSelectedOption?[i]});
//   }
//   return payload;
// }
//     return {key: _getValue()};
//   }

//   dynamic _getValue() {
//     switch (type) {
//       case "textarea" || "text" || "number":
//         return controller.text;
//       case "radio" || 'select':
//         log('-=-=-=-= selectedOption -=-=-=-= $selectedOption');
//         return selectedOption;
//       case "checkbox":
//         return multiSelectedOption;
//       case "image":
//         return image?.id;
//       case "file":
//         return image?.id;
//       case "date":
//         return selectedDate == null ? null : DateFormat("yyyy-MM-dd", 'en').format(selectedDate!);
//       case "location":
//         return {"lat": latLng?.latitude, "lng": latLng?.longitude, "location": location};
//       default:
//         return null;
//     }
//   }

//   ServicesFormModel.fromJson([Map<String, dynamic>? json]) {
//     id = stringFromJson(json, "id");
//     key = stringFromJson(json, "key");
//     type = stringFromJson(json, "type");
//     isRequired = boolFromJson(json, "is_required");
//     sortOrder = intFromJson(json, "sort_order");
//     options = List<String>.from(json?['options'] ?? []);
//     validation = stringFromJson(json, "validation");
//     final data = json?[LocaleKeys.lang.tr()];
//     label = stringFromJson(data, "label");
//     placeholder = stringNullFromJson(data, "placeholder");
//     helpText = stringFromJson(data, "help_text");
//   }

//   @override
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "key": key,
//     "type": type,
//     "is_required": isRequired,
//     "sort_order": sortOrder,
//     "options": options,
//     "validation": validation,
//     "label": label,
//     "placeholder": placeholder,
//     "help_text": helpText,
//   };
// }
