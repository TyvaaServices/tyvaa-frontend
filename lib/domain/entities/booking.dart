import 'package:hive/hive.dart';
import 'package:passenger_tyvaa/domain/entities/payment.dart';
import 'package:passenger_tyvaa/domain/entities/ride_instance.dart';

part 'booking.g.dart';

@HiveType(typeId: 6)
class Booking extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? rideInstanceId;

  @HiveField(2)
  int? seatsBooked;

  @HiveField(3)
  String? status;

  @HiveField(4)
  int? userId;

  @HiveField(5)
  Rideinstance? rideInstance;

  @HiveField(6)
  Payment? payment;

  Booking({
    this.id,
    this.rideInstanceId,
    this.seatsBooked,
    this.status,
    this.userId,
    this.rideInstance,
   this.payment,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int?,
      rideInstanceId: json['rideInstanceId'] as int?,
      seatsBooked: json['seatsBooked'] as int?,
      status: json['status'] as String?,
      userId: json['userId'] as int?,
      rideInstance: json['rideInstance'] != null
          ? Rideinstance.fromJson(json['rideInstance'])
          : null,
      payment: json['payment'] != null
          ? Payment.fromJson(json['payment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rideInstanceId': rideInstanceId,
      'seatsBooked': seatsBooked,
      'status': status,
      'userId': userId,
      'rideInstance': rideInstance?.toJson(),
      'payment': payment?.toJson(),
    };
  }
}
