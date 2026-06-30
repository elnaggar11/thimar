import 'package:flutter/material.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'base.dart';

class OrderModel extends Model {
  late final String status;
  late final String date;
  late final String time;
  late final double orderPrice;
  late final double deliveryPrice;
  late final double totalPrice;
  late final String clientName;
  late final String phone;
  late final String location;
  late final String deliveryPayer;
  late final List<OrderProductModel> products;
  late final String payType;
  late final String note;
  late final bool isVip;
  late final double vipDiscountPercentage;

  OrderModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    status = stringFromJson(json, "status");
    date = stringFromJson(json, "date");
    time = stringFromJson(json, "time");
    orderPrice = doubleFromJson(json, "order_price");
    deliveryPrice = doubleFromJson(json, "delivery_price");
    totalPrice = doubleFromJson(json, "total_price");
    clientName = stringFromJson(json, "client_name");
    phone = stringFromJson(json, "phone");
    location = stringFromJson(json, "location");
    deliveryPayer = stringFromJson(json, "delivery_payer");
    products = listFromJson<OrderProductModel>(
      json,
      "products",
      callback: (e) => OrderProductModel.fromJson(e),
    );
    payType = stringFromJson(json, "pay_type");
    note = stringFromJson(json, "note");
    isVip = boolFromJson(json, "is_vip");
    vipDiscountPercentage = doubleFromJson(json, "vip_discount_percentage");
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "date": date,
        "time": time,
        "order_price": orderPrice,
        "delivery_price": deliveryPrice,
        "total_price": totalPrice,
        "client_name": clientName,
        "phone": phone,
        "location": location,
        "delivery_payer": deliveryPayer,
        "products": products.map((e) => e.toJson()).toList(),
        "pay_type": payType,
        "note": note,
        "is_vip": isVip,
        "vip_discount_percentage": vipDiscountPercentage,
      };

  Color get backgroundColor {
    switch (status) {
      case 'pending': // بإنتظار الموافقة
        return '#EDF5E6'.color;
      case 'in_progress': // جاري التجهيز
      case 'on_the_way': // في الطريق
        return '#EDF5E6'.color;
      case 'finished': // منتهي
      case 'complete':
        return '#F5F5F5'.color; // Gray background
      case 'canceled': // طلب ملغي
        return '#FEE9EA'.color; // Red background
      default:
        return '#EDF5E6'.color;
    }
  }

  Color get textColor {
    switch (status) {
      case 'pending': // بإنتظار الموافقة
      case 'in_progress':
      case 'on_the_way':
        return '#4C8613'.color; // primary green
      case 'finished': // منتهي
      case 'complete':
        return '#9B9DA5'.color; // Gray
      case 'canceled': // طلب ملغي
        return '#F32428'.color; // Red
      default:
        return '#4C8613'.color;
    }
  }

  String get statusText {
    switch (status) {
      case 'pending':
        return 'بإنتظار الموافقة';
      case 'in_progress':
        return 'جاري التجهيز';
      case 'on_the_way':
        return 'في الطريق';
      case 'finished':
      case 'complete':
        return 'منتهي';
      case 'canceled':
        return 'طلب ملغي';
      default:
        return status;
    }
  }
}

class OrderProductModel extends Model {
  late final String name;
  late final String url;
  late final double price;

  OrderProductModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    url = stringFromJson(json, "url");
    price = doubleFromJson(json, "price");
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "price": price,
      };
}
