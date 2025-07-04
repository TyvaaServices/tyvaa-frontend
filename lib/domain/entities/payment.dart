import 'package:hive/hive.dart';

part 'payment.g.dart';

@HiveType(typeId: 4)
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

  Payment({
    required this.transactionId,
    this.phone,
    required this.amount,
    this.status = 'PENDING',
    this.currency,
    this.paymentMethod,
    this.metadata,
    this.operatorId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      transactionId: json['transaction_id'] as String,
      phone: json['phone'] as String?,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String? ?? 'PENDING',
      currency: json['currency'] as String?,
      paymentMethod: json['payment_method'] as String?,
      metadata: json['metadata'] as String?,
      operatorId: json['operator_id'] as String?,
    );
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
    };
  }
}
