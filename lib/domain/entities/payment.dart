import 'package:hive/hive.dart';

part 'payment.g.dart';

@HiveType(typeId: 7)
class Payment extends HiveObject {
  @HiveField(0)
  String transactionId;

  @HiveField(1)
  String? phone;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String status;

  @HiveField(4)
  String? currency;

  @HiveField(5)
  String? paymentMethod;

  @HiveField(6)
  String? metadata;

  @HiveField(7)
  String? operatorId;

  @HiveField(8)
  double? fee;

  @HiveField(9)
  String? provider;

  @HiveField(10)
  String? externalTransactionId;

  Payment({
    required this.transactionId,
    this.phone,
    required this.amount,
    this.status = 'PENDING',
    this.currency,
    this.paymentMethod,
    this.metadata,
    this.operatorId,
    this.fee,
    this.provider,
    this.externalTransactionId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      transactionId:
          json['transactionId'] as String? ??
          json['transaction_id'] as String? ??
          '',
      phone: json['phone'] as String?,
      amount: _parseDouble(json['amount']),
      status: json['status'] as String? ?? 'PENDING',
      currency: json['currency'] as String?,
      paymentMethod:
          json['paymentMethod'] as String? ?? json['payment_method'] as String?,
      metadata: json['metadata']?.toString(),
      operatorId:
          json['operatorId'] as String? ?? json['operator_id'] as String?,
      fee: _parseDouble(json['fee']),
      provider: json['provider'] as String?,
      externalTransactionId: json['externalTransactionId'] as String?,
    );
  }

  /// Helper method to safely parse string or numeric values to double
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return 0.0;
      }
    }
    return 0.0;
  }

  /// Helper method to safely parse string or numeric values to nullable double
  static double? _parseDoubleNullable(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'phone': phone,
      'amount': amount,
      'status': status,
      'currency': currency,
      'payment_method': paymentMethod,
      'metadata': metadata,
      'operator_id': operatorId,
      'fee': fee,
      'provider': provider,
      'externalTransactionId': externalTransactionId,
    };
  }
}
