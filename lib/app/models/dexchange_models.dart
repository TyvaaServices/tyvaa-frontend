import 'package:json_annotation/json_annotation.dart';

/// Payment methods supported by DEXCHANGE
enum DexchangePaymentMethod {
  @JsonValue('orange')
  orange,
  @JsonValue('wave')
  wave,
  @JsonValue('mtn')
  mtn,
  @JsonValue('moov')
  moov,
  @JsonValue('free')
  free,
  @JsonValue('wizall')
  wizall,
}

/// West African countries supported by DEXCHANGE
enum DexchangeCountry {
  @JsonValue('SN')
  senegal,
  @JsonValue('ML')
  mali,
  @JsonValue('CI')
  ivoryCoast,
  @JsonValue('CM')
  cameroon,
}

/// Payment instructions from DEXCHANGE API
class DexchangePaymentInstructions {
  final String message;
  final int amount;
  final String phoneNumber;
  final String paymentMethod;
  final String transactionId;
  final List<String> nextSteps;

  const DexchangePaymentInstructions({
    required this.message,
    required this.amount,
    required this.phoneNumber,
    required this.paymentMethod,
    required this.transactionId,
    required this.nextSteps,
  });

  static DexchangePaymentInstructions fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DexchangePaymentInstructions(
        message: '',
        amount: 0,
        phoneNumber: '',
        paymentMethod: '',
        transactionId: '',
        nextSteps: [],
      );
    }
    return DexchangePaymentInstructions(
      message: json['message'] as String? ?? '',
      amount: json['amount'] as int? ?? 0,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? '',
      transactionId: json['transactionId'] as String? ?? '',
      nextSteps:
          (json['nextSteps'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'amount': amount,
      'phoneNumber': phoneNumber,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'nextSteps': nextSteps,
    };
  }
}

/// Available payment method info from backend
class DexchangePaymentMethodInfo {
  final String code;
  final String operator;
  final String displayName;
  final String country;

  const DexchangePaymentMethodInfo({
    required this.code,
    required this.operator,
    required this.displayName,
    required this.country,
  });

  static DexchangePaymentMethodInfo fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const DexchangePaymentMethodInfo(
        code: '',
        operator: '',
        displayName: '',
        country: '',
      );
    }
    return DexchangePaymentMethodInfo(
      code: json['code'] as String? ?? '',
      operator: json['operator'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'operator': operator,
      'displayName': displayName,
      'country': country,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DexchangePaymentMethodInfo &&
        other.displayName == displayName;
  }

  @override
  int get hashCode {
    return displayName.hashCode;
  }
}
