class PaymentResponse {
  final String transactionId;
  final num amount;
  final String currency;
  final String status;
  final String paymentMethod;
  final String description;
  final String metadata;
  final String operatorId;
  final DateTime paymentDate;

  PaymentResponse({
    required this.transactionId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    required this.description,
    required this.metadata,
    required this.operatorId,
    required this.paymentDate,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      transactionId: json['transaction_id'] as String,
      amount: json['amount'] as num,
      currency: json['currency'] as String,
      status: json['status'] as String,
      paymentMethod: json['payment_method'] as String,
      description: json['description'] as String,
      metadata: json['metadata'] as String,
      operatorId: json['operator_id'] as String,
      paymentDate: DateTime.parse(json['payment_date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'payment_method': paymentMethod,
      'description': description,
      'metadata': metadata,
      'operator_id': operatorId,
      'payment_date': paymentDate.toIso8601String(),
    };
  }
}
