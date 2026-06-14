import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

import 'base.dart';

class OrderModel extends Model {
  late final String orderNumber;
  late final String phone;
  late final String status;
  late final String statusLabel;
  late final List<OrderItem> items;
  late final double subTotal;
  late final double vat;
  late final double shippingFee;
  late final double total;
  late final double totalBeforePoints;
  late final double codFees;
  late final double loyaltyPointsUsed;
  late final double loyaltyPointsValue;
  late final double loyaltyPointsEarned;
  late final String currency;
  late final String paymentStatus;
  late final String paymentMethod;
  late final String? deliveryImage;
  late final String? note;
  late final List<TimelineStep> timeline;
  String? createdAt;
  String? paidAt;
  String? completedAt;

  late final DriverModel driver;

  late bool canRate;

  String get payIcon {
    switch (paymentMethod) {
      case 'cash':
        return Assets.icons.wallet;
      case 'myfatoorah':
        return Assets.icons.shoppingCart;
      default:
        return Assets.icons.wallet;
    }
  }

  String get payLable {
    switch (paymentMethod) {
      case 'cash':
        return LocaleKeys.cash_payment.tr();
      case 'myfatoorah':
        return LocaleKeys.online_payment.tr();
      default:
        return '';
    }
  }
  // String get statusLabel {
  //   if (statusLabelApi.isNotEmpty) return statusLabelApi;
  //   switch (status) {
  //     case 'pending':
  //       return LocaleKeys.pending.tr();
  //     case 'paid' ||
  //         'processing' ||
  //         'shipped' ||
  //         'picked_up' ||
  //         'out_for_delivery':
  //       return LocaleKeys.inProgress.tr();
  //     case 'delivered':
  //       return LocaleKeys.completed.tr();
  //     case 'canceled':
  //       return LocaleKeys.canceled.tr();
  //     default:
  //       return status;
  //   }
  // }

  String get paymentStatusLabel {
    switch (paymentStatus) {
      case 'pending':
        return "(${LocaleKeys.unpaid.tr()})";
      case 'failed':
        return "(${LocaleKeys.paymentFailed.tr()})";
      default:
        return '';
    }
  }

  Color get backgroundColor {
    switch (status) {
      case 'pending':
        return "#FFECD6".color;
      case 'paid' || 'processing' || 'shipped':
        return '#E6FFE7'.color;
      case 'delivered':
        return "#F5F7F8".color;
      case 'cancelled':
        return "#FEE9EA".color;
      default:
        return Colors.transparent;
    }
  }

  Color get textColor {
    switch (status) {
      case 'pending':
        return Colors.orangeAccent;
      case 'paid' || 'processing' || 'shipped':
        return '#28AF4A'.color;
      case 'delivered':
        return "#9B9DA5".color;
      case 'cancelled':
        return '#F32428'.color;
      default:
        return Colors.transparent;
    }
  }

  List<TimelineStep> _buildTimeline(Map<String, dynamic> status) {
    String? createdAt = status['created_at'];
    String? assignedAt = status['assigned_at'];
    String? pickedUpAt = status['picked_up_at'];
    String? outForDeliveryAt = status['out_for_delivery_at'];
    String? deliveredAt = status['delivered_at'];
    return [
      TimelineStep(
        title: LocaleKeys.created.tr(),
        time: createdAt ?? '----',
        isDone: createdAt != null,
      ),
      TimelineStep(
        title: LocaleKeys.assignedAt.tr(),
        time: assignedAt ?? '----',
        isDone: assignedAt != null,
      ),
      TimelineStep(
        title: LocaleKeys.pickedUpAt.tr(),
        time: pickedUpAt ?? '----',
        isDone: pickedUpAt != null,
      ),
      TimelineStep(
        title: LocaleKeys.outForDeliveryAt.tr(),
        time: outForDeliveryAt ?? '----',
        isDone: outForDeliveryAt != null,
      ),
      TimelineStep(
        title: LocaleKeys.deliveredAt.tr(),
        time: deliveredAt ?? '----',
        isDone: deliveredAt != null,
      ),
    ];
  }

  OrderModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    orderNumber = stringFromJson(json, "order_number");
    phone = stringNullFromJson(json, "phone") ?? '';
    status = stringFromJson(json, "status");
    statusLabel = stringNullFromJson(json, "status_label") ?? '';
    note = stringNullFromJson(json, "note");
    items = listFromJson<OrderItem>(
      json,
      "items",
      callback: (e) => OrderItem.fromJson(e),
    );
    canRate = boolFromJson(json, "can_rate");
    subTotal = doubleFromJson(json, "subtotal");
    vat = doubleFromJson(json, "vat");
    shippingFee = doubleFromJson(json, "delivery_fees");
    codFees = doubleFromJson(json, "cod_fees");
    totalBeforePoints = doubleFromJson(json, "total_before_points");
    loyaltyPointsUsed = doubleFromJson(json, "loyalty_points_used");
    loyaltyPointsValue = doubleFromJson(json, "loyalty_points_value");
    loyaltyPointsEarned = doubleFromJson(json, "loyalty_points_earned");
    total = doubleFromJson(json, "total");
    currency = stringNullFromJson(json, "currency") ?? '';
    deliveryImage = stringNullFromJson(json, "delivery_image");
    paymentStatus = stringFromJson(json, "payment_status");
    paymentMethod = stringNullFromJson(json, "payment_method") ?? '';

    final timelineJson =
        json?['status_timeline'] as Map<String, dynamic>? ?? {};
    createdAt =
        stringNullFromJson(timelineJson, "created_at") ??
        stringNullFromJson(json, "created_at");
    paidAt = stringNullFromJson(timelineJson, "paid_at");
    completedAt = stringNullFromJson(timelineJson, "delivered_at");

    timeline = _buildTimeline(json?['status_timeline']);
    driver = DriverModel.fromJson(json?['driver']);
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "phone": phone,
    "status": status,
    "status_label": statusLabel,
    "items": items.map((e) => e.toJson()).toList(),
    "subtotal": subTotal,
    "vat": vat,
    "delivery_fees": shippingFee,
    "cod_fees": codFees,
    "total_before_points": totalBeforePoints,
    "loyalty_points_used": loyaltyPointsUsed,
    "loyalty_points_value": loyaltyPointsValue,
    "loyalty_points_earned": loyaltyPointsEarned,
    "total": total,
    "currency": currency,
    "payment_status": paymentStatus,
    "payment_method": paymentMethod,
    "paid_at": paidAt,
    "created_at": createdAt,
    "completed_at": completedAt,
  };
}

class OrderItem extends Model {
  late final int quantity;
  late final double unitPrice;
  late final double totalPrice;
  late final String productName;
  String? productImage;
  int? productId;
  late final double avgRate;

  OrderItem.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    productId = intNullFromJson(json, "product_id");
    productName = stringFromJson(json, "product_name");
    productImage = stringNullFromJson(json?['product_image'], "path");
    quantity = intFromJson(json, "quantity");
    unitPrice = doubleFromJson(json, "unit_price");
    totalPrice = doubleFromJson(json, "total");
    avgRate = doubleFromJson(json, "product_avg_rate");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "product_image": {'path': productImage},
    "quantity": quantity,
    "unit_price": unitPrice,
    "total": totalPrice,
  };
}

class TimelineStep {
  final String title;
  final String time;
  final bool isDone;

  const TimelineStep({
    required this.title,
    required this.time,
    required this.isDone,
  });
}

class DriverModel extends Model {
  late final String fullNamem, phone, phoneCode, phoneWithCode, avatar;

  DriverModel.fromJson(Map<String, dynamic>? json) {
    id = stringFromJson(json, "id");
    fullNamem = stringFromJson(json, "full_name");
    phone = stringFromJson(json, "phone");
    phoneCode = stringFromJson(json, "phone_code");
    phoneWithCode = stringFromJson(json, "phone_with_code");
    avatar = stringFromJson(json?['avatar'], "path");
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "full_name": fullNamem,
      "phone": phone,
      "phone_code": phoneCode,
      "phone_with_code": phoneWithCode,
      "avatar": avatar,
    };
  }
}
