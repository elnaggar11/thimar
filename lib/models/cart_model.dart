import 'base.dart';

class CartModel extends Model {
  late final List<CartItemModel> items;
  late final double totalPriceBeforeDiscount;
  late final double totalDiscount;
  late final double totalPriceWithVat;
  late final double deliveryCost;
  late final double freeDeliveryPrice;
  late final double vat;
  late final int isVip;
  late final double vipDiscountPercentage;
  late final double minVipPrice;
  late final String vipMessage;

  CartModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    items = listFromJson<CartItemModel>(
      json,
      "data",
      callback: (e) => CartItemModel.fromJson(e),
    );
    totalPriceBeforeDiscount = doubleFromJson(json, "total_price_before_discount");
    totalDiscount = doubleFromJson(json, "total_discount");
    totalPriceWithVat = doubleFromJson(json, "total_price_with_vat");
    deliveryCost = doubleFromJson(json, "delivery_cost");
    freeDeliveryPrice = doubleFromJson(json, "free_delivery_price");
    vat = doubleFromJson(json, "vat");
    isVip = intFromJson(json, "is_vip");
    vipDiscountPercentage = doubleFromJson(json, "vip_discount_percentage");
    minVipPrice = doubleFromJson(json, "min_vip_price");
    vipMessage = stringFromJson(json, "vip_message");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "data": items.map((e) => e.toJson()).toList(),
    "total_price_before_discount": totalPriceBeforeDiscount,
    "total_discount": totalDiscount,
    "total_price_with_vat": totalPriceWithVat,
    "delivery_cost": deliveryCost,
    "free_delivery_price": freeDeliveryPrice,
    "vat": vat,
    "is_vip": isVip,
    "vip_discount_percentage": vipDiscountPercentage,
    "min_vip_price": minVipPrice,
    "vip_message": vipMessage,
  };
}

class CartItemModel extends Model {
  late int itemId;
  late String title;
  late String image;
  late int amount;
  late double priceBeforeDiscount;
  late double discount;
  late double price;
  late double remainingAmount;

  CartItemModel.fromJson([Map<String, dynamic>? json]) {
    itemId = intFromJson(json, "id");
    id = itemId.toString();
    title = stringFromJson(json, "title");
    image = stringFromJson(json, "image");
    amount = intFromJson(json, "amount");
    priceBeforeDiscount = doubleFromJson(json, "price_before_discount");
    discount = doubleFromJson(json, "discount");
    price = doubleFromJson(json, "price");
    remainingAmount = doubleFromJson(json, "remaining_amount");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": itemId,
    "title": title,
    "image": image,
    "amount": amount,
    "price_before_discount": priceBeforeDiscount,
    "discount": discount,
    "price": price,
    "remaining_amount": remainingAmount,
  };
}
