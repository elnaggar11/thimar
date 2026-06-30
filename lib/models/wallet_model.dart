import 'base.dart';

class WalletModel extends Model {
  late final String balance;
  late final String withdrawalBalance;
  late final num totalBalance;
  late final List<WalletTransaction> transactions;
  late final LoyaltyInfoModel loyalty;

  WalletModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, 'id'); // optional backend id if exists
    final walletBalance = stringFromJson(json, 'wallet');
    balance = walletBalance.isNotEmpty ? walletBalance : stringFromJson(json, 'balance');
    withdrawalBalance = stringFromJson(json, 'withdrawal_balance');
    totalBalance = numFromJson(json, 'total_balance');
    // Safely extract transactions list
    List<dynamic> txList = [];
    if (json?['data'] is List) {
      txList = json!['data'];
    } else if (json?['transactions'] is List) {
      txList = json!['transactions'];
    } else if (json?['wallet_transactions'] is List) {
      txList = json!['wallet_transactions'];
    } else if (json?['wallet_transactions'] is Map && json!['wallet_transactions']['data'] is List) {
      txList = json['wallet_transactions']['data'];
    }
    
    transactions = txList
        .map((e) => WalletTransaction.fromJson(e as Map<String, dynamic>?))
        .toList();
        
    loyalty = LoyaltyInfoModel.fromJson(
      json?['loyalty'] as Map<String, dynamic>?,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'balance': balance,
    'withdrawal_balance': withdrawalBalance,
    'total_balance': totalBalance,
    'transactions': transactions.map((e) => e.toJson()).toList(),
    'loyalty': loyalty.toJson(),
  };
}

class WalletTransaction extends Model {
  late final String type;
  late final String status;
  late final String amount;
  late final String formattedAmount;
  late final String description;
  late final bool isCredit;
  late final bool isUp;
  late final Map<String, dynamic> meta;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final String createdAtFormat;
  late final String walletId;

  WalletTransaction.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, 'id');
    walletId = stringFromJson(json, 'wallet_id');
    final transType = stringFromJson(json, 'transaction_type');
    type = transType.isNotEmpty ? transType : stringFromJson(json, 'type');
    status = stringFromJson(json, 'status');
    amount = stringFromJson(json, 'amount');
    formattedAmount = stringFromJson(json, 'formatted_amount');
    final statusTrans = stringFromJson(json, 'status_trans');
    description = statusTrans.isNotEmpty ? statusTrans : stringFromJson(json, 'description');
    isCredit = boolFromJson(json, 'is_credit');
    isUp = boolFromJson(json, 'is_up');
    meta = (json?['meta'] as Map<String, dynamic>?) ?? {};
    final dateStr = stringFromJson(json, 'date');
    if (dateStr.isNotEmpty) {
      createdAt = dateFromJson(json, 'date');
      createdAtFormat = dateStr;
    } else {
      createdAt = dateFromJson(json, 'created_at');
      createdAtFormat = stringFromJson(json, 'created_at_format');
    }
    updatedAt = dateFromJson(json, 'updated_at');
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'wallet_id': walletId,
    'type': type,
    'status': status,
    'amount': amount,
    'formatted_amount': formattedAmount,
    'description': description,
    'is_credit': isCredit,
    'is_up': isUp,
    'meta': meta,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'created_at_format': createdAtFormat,
  };
}

class LoyaltyInfoModel extends Model {
  late final bool enabled;
  late final double pointsBalance;
  late final double pointValue;
  late final num minOrderAmount;
  late final num maxPointsPerOrder;
  late final int expiryDays;

  LoyaltyInfoModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, 'id');
    enabled = boolFromJson(json, 'enabled');
    pointsBalance = doubleFromJson(json, 'points_balance');
    pointValue = doubleFromJson(json, 'point_value');
    minOrderAmount = numFromJson(json, 'min_order_amount');
    maxPointsPerOrder = numFromJson(json, 'max_points_per_order');
    expiryDays = intFromJson(json, 'expiry_days');
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'enabled': enabled,
    'points_balance': pointsBalance,
    'point_value': pointValue,
    'min_order_amount': minOrderAmount,
    'max_points_per_order': maxPointsPerOrder,
    'expiry_days': expiryDays,
  };
}
