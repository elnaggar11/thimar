import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thimar/gen/locale_keys.g.dart';

import '../core/utils/extensions.dart';
import 'base.dart';
import 'order_model.dart';
import 'service_model.dart';

class RequestModel extends Model {
  late final ServiceModel service;
  late final String status;
  late final String statusLabel;
  late final double price;
  late final String currency;
  late final String? paymentMethod;
  late final String paymentStatus;
  late final double totalBeforePoints;
  late final double loyaltyPointsUsed;
  late final double loyaltyPointsValue;
  late final double loyaltyPointsEarned;
  late final List<RequestFormData>? formData;
  List<RequestMedia> images = [];
  RequestAddress? address;
  RequestStatusTimeline? statusTimeline;
  double? rating;
  double? serviceRateAvg;
  double? rateAvg;
  late final String createdAt;
  String? updatedAt;

  List<TimelineStep> get timeline => [
    TimelineStep(
      title: LocaleKeys.processing.tr(),
      time: statusTimeline?.createdAt ?? '',
      isDone: statusTimeline?.createdAt != null,
    ),
    if (statusTimeline?.rejectedAt == null) ...[
      TimelineStep(
        title: LocaleKeys.priceSent.tr(),
        time: statusTimeline?.pricedAt ?? '',
        isDone: statusTimeline?.pricedAt != null,
      ),
      TimelineStep(
        title: LocaleKeys.executing.tr(),
        time: statusTimeline?.approvedAt ?? '',
        isDone: statusTimeline?.approvedAt != null,
      ),
      TimelineStep(
        title: LocaleKeys.completed.tr(),
        time: statusTimeline?.paidAt ?? '',
        isDone: statusTimeline?.paidAt != null,
      ),
    ] else
      TimelineStep(
        title: LocaleKeys.canceled.tr(),
        time: statusTimeline?.rejectedAt ?? '',
        isDone: statusTimeline?.rejectedAt != null,
      ),
  ];

  Color get backgroundColor {
    switch (status) {
      case 'pending_pricing':
        return "#FCF9EF".color;
      case 'paid' || 'processing' || 'shipped':
        return '#E6FFE7'.color;
      case 'delivered':
        return "#F5F7F8".color;
      case 'cancelled':
        return "#FEE9EA".color;
      case 'priced':
        return "#F5EBF6".color;
      default:
        return Colors.transparent;
    }
  }

  Color get textColor {
    switch (status) {
      case 'pending_pricing':
        return '#F1CD22'.color;
      case 'paid' || 'processing' || 'shipped':
        return '#28AF4A'.color;
      case 'delivered':
        return "#9B9DA5".color;
      case 'priced':
        return "#9732A4".color;
      case 'cancelled':
        return '#F32428'.color;
      default:
        return Colors.transparent;
    }
  }

  RequestModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    service = ServiceModel.fromJson(json?["service"] as Map<String, dynamic>?);
    status = stringFromJson(json, "status");
    statusLabel = stringFromJson(json, "status_label");
    price = doubleFromJson(json, "price");
    currency = stringFromJson(json, "currency");
    paymentMethod = stringNullFromJson(json, "payment_method");
    paymentStatus = stringFromJson(json, "payment_status");
    totalBeforePoints = doubleFromJson(json, "total_before_points");
    loyaltyPointsUsed = doubleFromJson(json, "loyalty_points_used");
    loyaltyPointsValue = doubleFromJson(json, "loyalty_points_value");
    loyaltyPointsEarned = doubleFromJson(json, "loyalty_points_earned");

    formData = listFromJson<RequestFormData>(
      json,
      "form_fields",
      callback: (e) => RequestFormData.fromJson(e),
    );
    images = listFromJson<RequestMedia>(
      json,
      "images",
      callback: (e) => RequestMedia.fromJson(e),
    );
    address = json?["address"] is Map<String, dynamic>
        ? RequestAddress.fromJson(json?["address"] as Map<String, dynamic>)
        : null;
    statusTimeline = json?["status_timeline"] is Map<String, dynamic>
        ? RequestStatusTimeline.fromJson(
            json?["status_timeline"] as Map<String, dynamic>,
          )
        : null;

    rating = doubleNullFromJson(json, "rating");
    serviceRateAvg = doubleNullFromJson(json, "service_rate_avg");
    rateAvg = doubleNullFromJson(json, "rate_avg");
    createdAt = stringFromJson(json, "created_at");
    updatedAt = stringNullFromJson(json, "updated_at");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "service": service.toJson(),
    "status": status,
    "status_label": statusLabel,
    "price": price,
    "currency": currency,
    "payment_method": paymentMethod,
    "payment_status": paymentStatus,
    "total_before_points": totalBeforePoints,
    "loyalty_points_used": loyaltyPointsUsed,
    "loyalty_points_value": loyaltyPointsValue,
    "loyalty_points_earned": loyaltyPointsEarned,
    "form_data": formData?.map((e) => e.toJson()).toList(),
    "images": images.map((e) => e.toJson()).toList(),
    "address": address?.toJson(),
    "status_timeline": statusTimeline?.toJson(),
    "rating": rating,
    "service_rate_avg": serviceRateAvg,
    "rate_avg": rateAvg,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class RequestMedia extends Model {
  late final String path;
  late final String type;
  late final String option;
  late final String fieldKey;

  RequestMedia.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    path = stringFromJson(json, "path");
    type = stringFromJson(json, "type");
    option = stringFromJson(json, "option");
    fieldKey = stringFromJson(json, "field_key");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "path": path,
    "type": type,
    "option": option,
    "field_key": fieldKey,
  };
}

class RequestLocation {
  final double lat;
  final double lng;
  final String location;

  RequestLocation({
    required this.lat,
    required this.lng,
    required this.location,
  });

  factory RequestLocation.fromJson(Map<String, dynamic> json) =>
      RequestLocation(
        lat: (json["lat"] as num?)?.toDouble() ?? 0,
        lng: (json["lng"] as num?)?.toDouble() ?? 0,
        location: json["location"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "location": location,
  };
}

class RequestFormData extends Model {
  late final String title;
  late final String value;
  late final String type;

  RequestFormData.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    title = stringFromJson(json, "title");
    type = stringFromJson(json, "type");
    if (type == 'location') {
      value = stringFromJson(json?['value'], "location");
    } else if (type == 'image') {
      value = stringFromJson(json?['value'], "path");
    } else {
      value = stringFromJson(json, "value");
    }
    // {
    //             "id": 4,
    //             "key": "location",
    //             "label": LocaleKeys.location.tr(),
    //             "placeholder": LocaleKeys.select_location.tr(),
    //             "help_text": null,
    //             "type": "location",
    //             "value": {
    //                 "lat": 31.13599190748128,
    //                 "lng": 31.85406412929296,
    //                 "location": "Al Mawaged, Al Manzalah, Dakahlia, Egypt"
    //             },
    //             "is_required": true,
    //             "options": null,
    //             "validation": null,
    //             "sort_order": 1
    //         }
  }

  @override
  Map<String, dynamic> toJson() => {};
}

class RequestStatusTimeline {
  final String? createdAt;
  final String? pricedAt;
  final String? approvedAt;
  final String? rejectedAt;
  final String? paidAt;

  RequestStatusTimeline({
    this.createdAt,
    this.pricedAt,
    this.approvedAt,
    this.rejectedAt,
    this.paidAt,
  });

  factory RequestStatusTimeline.fromJson(Map<String, dynamic> json) =>
      RequestStatusTimeline(
        createdAt: json["created_at"]?.toString(),
        pricedAt: json["priced_at"]?.toString(),
        approvedAt: json["approved_at"]?.toString(),
        rejectedAt: json["rejected_at"]?.toString(),
        paidAt: json["paid_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt,
    "priced_at": pricedAt,
    "approved_at": approvedAt,
    "rejected_at": rejectedAt,
    "paid_at": paidAt,
  };
}

class RequestAddress {
  final String title;
  final String street;
  final String location;
  final String district;
  final String city;
  final double lat;
  final double lng;

  RequestAddress({
    required this.title,
    required this.street,
    required this.location,
    required this.district,
    required this.city,
    required this.lat,
    required this.lng,
  });

  factory RequestAddress.fromJson(Map<String, dynamic> json) => RequestAddress(
    title: json["title"]?.toString() ?? '',
    street: json["street"]?.toString() ?? '',
    location: json["location"]?.toString() ?? '',
    district: json["district"]?.toString() ?? '',
    city: json["city"]?.toString() ?? '',
    lat: (json["lat"] as num?)?.toDouble() ?? 0,
    lng: (json["lng"] as num?)?.toDouble() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "street": street,
    "location": location,
    "district": district,
    "city": city,
    "lat": lat,
    "lng": lng,
  };
}

class TimelineStep {
  final String title;
  final String time;
  final bool isDone;

  TimelineStep({
    required this.title,
    required this.time,
    required this.isDone,
  });
}
