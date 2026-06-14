import 'base.dart';

class CartModel extends Model {
  late final List<CartItemModle> items;
  late final CartSummaryModel summary;
  late final List<VendorPaymentSummaryModel> vendorPaymentMethods;
  late final double totalPayNow;
  late final double totalDeferred;
  late final String deliveryMethod;
  String? couponType;
  double? couponValue;
  String? couponMessage;
  int? couponStatus;
  double? discount;

  CartModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    items = listFromJson<CartItemModle>(
      json,
      "items",
      callback: (e) => CartItemModle.fromJson(e),
    );
    summary = CartSummaryModel.fromJson(json);
    vendorPaymentMethods = listFromJson<VendorPaymentSummaryModel>(
      json,
      "vendor_payment_methods",
      callback: (e) => VendorPaymentSummaryModel.fromJson(e),
    );
    totalPayNow = doubleFromJson(json, "total_pay_now");
    totalDeferred = doubleFromJson(json, "total_deferred");
    deliveryMethod = stringFromJson(json, "delivery_method");
    couponType = stringNullFromJson(json, "coupon_type");
    couponValue = doubleNullFromJson(json, "value");
    couponMessage = stringNullFromJson(json, "coupon_message");
    couponStatus = intNullFromJson(json, "coupon_status");
    discount = doubleNullFromJson(json, "discount");
  }

  VendorPaymentSummaryModel? paymentSummaryForVendor(String vendorId) {
    for (final vendorPayment in vendorPaymentMethods) {
      if (vendorPayment.vendorId == vendorId) return vendorPayment;
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "items": items.map((e) => e.toJson()).toList(),
    "summary": summary.toJson(),
    "vendor_payment_methods": vendorPaymentMethods
        .map((e) => e.toJson())
        .toList(),
    "total_pay_now": totalPayNow,
    "total_deferred": totalDeferred,
    "delivery_method": deliveryMethod,
  };
}

class CartItemModle extends Model {
  late final int productId;
  late final String productName;
  late final String productDescription;
  late final String image;
  late final int quantity;
  late final double unitPrice;
  late final double priceAfterDiscount;
  late final double currentDiscount;
  late final double total;
  late final int variantId;
  late final String vendorId;
  late final String vendorName;
  late final bool vendorSupportsDeferred;
  late final bool vendorSupportsOnline;
  late final bool vendorSupportsWallet;
  late final bool isFavorite;
  late final List<VendorPaymentMethodModel> vendorPaymentMethods;

  CartItemModle.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    productId = intFromJson(json, "product_id");
    productName = stringFromJson(json, "product_name");
    productDescription = stringFromJson(json, "product_description");
    final productMain = json?["product_main"];
    image = stringFromJson(productMain is Map ? productMain : null, "path");
    quantity = intFromJson(json, "quantity");
    unitPrice = doubleFromJson(json, "price");
    priceAfterDiscount = doubleFromJson(json, "price_after_discount");

    final parsedCurrentDiscount = doubleFromJson(
      json,
      "current_discount",
      defaultValue: double.nan,
    );
    currentDiscount = parsedCurrentDiscount.isNaN
        ? doubleFromJson(json, "discount")
        : parsedCurrentDiscount;

    total = doubleFromJson(json, "total");
    variantId = intFromJson(json, "variant_id");
    isFavorite = boolFromJson(json, "is_favorite");

    final vendorJson = json?["vendor"];
    final vendorMap = vendorJson is Map<String, dynamic> ? vendorJson : null;
    vendorId = stringFromJson(vendorMap, "id");
    vendorName = stringFromJson(vendorMap, "name").trim().isNotEmpty
        ? stringFromJson(vendorMap, "name")
        : stringFromJson(json, "vendor_name");

    vendorPaymentMethods = listFromJson<VendorPaymentMethodModel>(
      vendorMap,
      "payment_methods",
      callback: (e) => VendorPaymentMethodModel.fromJson(e),
    );

    vendorSupportsDeferred =
        _isMethodAvailable('deferred') ||
        boolFromJson(vendorMap, "is_deferred_payment_available");
    vendorSupportsOnline = vendorPaymentMethods.isEmpty
        ? true
        : _isMethodAvailable('online');
    vendorSupportsWallet =
        _isMethodAvailable('wallet') ||
        boolFromJson(vendorMap, "is_wallet_payment_available");
  }

  bool _isMethodAvailable(String method) {
    return vendorPaymentMethods.any(
      (paymentMethod) =>
          paymentMethod.method == method && paymentMethod.available,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "product_description": productDescription,
    "quantity": quantity,
    "price": unitPrice,
    "price_after_discount": priceAfterDiscount,
    "current_discount": currentDiscount,
    "total": total,
    "variant_id": variantId,
    "vendor_id": vendorId,
    "vendor_name": vendorName,
    "vendor_supports_deferred": vendorSupportsDeferred,
    "vendor_supports_online": vendorSupportsOnline,
    "vendor_supports_wallet": vendorSupportsWallet,
    "vendor_payment_methods": vendorPaymentMethods
        .map((e) => e.toJson())
        .toList(),
  };
}

class VendorPaymentSummaryModel extends Model {
  late final String vendorId;
  late final String selectedMethod;
  late final double? payNowAmount;
  late final double? deferredAmount;
  late final List<VendorPaymentMethodModel> paymentMethods;

  VendorPaymentSummaryModel.fromJson([Map<String, dynamic>? json]) {
    vendorId = stringFromJson(json, "vendor_id");
    id = vendorId;
    selectedMethod = _normalizePaymentMethod(
      stringFromJson(json, "selected_method"),
    );
    payNowAmount = doubleNullFromJson(json, "pay_now_amount");
    deferredAmount = doubleNullFromJson(json, "deferred_amount");
    paymentMethods = listFromJson<VendorPaymentMethodModel>(
      json,
      "payment_methods",
      callback: (e) => VendorPaymentMethodModel.fromJson(e),
    );
  }

  VendorPaymentMethodModel? methodByKey(String method) {
    for (final paymentMethod in paymentMethods) {
      if (paymentMethod.method == method) return paymentMethod;
    }
    return null;
  }

  bool isMethodAvailable(String method) =>
      methodByKey(method)?.available ?? false;

  @override
  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "selected_method": selectedMethod,
    "pay_now_amount": payNowAmount,
    "deferred_amount": deferredAmount,
    "payment_methods": paymentMethods.map((e) => e.toJson()).toList(),
  };
}

class VendorPaymentMethodModel extends Model {
  late final String vendorId;
  late final String method;
  late final String label;
  late final bool available;
  late final bool selected;
  late final double? payNowAmount;
  late final double? deferredAmount;
  late final double? walletBalance;

  VendorPaymentMethodModel.fromJson([Map<String, dynamic>? json]) {
    vendorId = stringFromJson(json, "vendor_id");
    method = _normalizePaymentMethod(stringFromJson(json, "method"));
    id = method;
    label = stringFromJson(json, "label");
    available = boolFromJson(json, "available", defaultValue: false);
    selected = boolFromJson(json, "selected");
    payNowAmount = doubleNullFromJson(json, "pay_now_amount");
    deferredAmount = doubleNullFromJson(json, "deferred_amount");
    walletBalance = doubleNullFromJson(json, "wallet_balance");
  }

  @override
  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "method": method,
    "label": label,
    "available": available,
    "selected": selected,
    "pay_now_amount": payNowAmount,
    "deferred_amount": deferredAmount,
    "wallet_balance": walletBalance,
  };
}

class CartSummaryModel extends Model {
  late final double subtotal;
  late final double shippingCost;
  late final double vat;
  late final double total;

  CartSummaryModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    subtotal = doubleFromJson(json, "sub_total");
    shippingCost = doubleFromJson(json, "shipping_cost");
    vat = doubleFromJson(json, "vat");
    total = doubleFromJson(json, "total");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_total": subtotal,
    "shipping_cost": shippingCost,
    "vat": vat,
    "total": total,
  };
}

String _normalizePaymentMethod(String method) {
  switch (method.trim().toLowerCase()) {
    case 'myfatoorah':
    case 'online_payment':
      return 'online';
    case 'deferred_payment':
      return 'deferred';
    case 'wallet_payment':
      return 'wallet';
    default:
      return method.trim().toLowerCase();
  }
}
