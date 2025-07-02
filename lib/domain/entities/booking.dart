
import 'package:hive/hive.dart';
import 'package:passenger_tyvaa/domain/entities/ride_instance.dart';
part 'booking.g.dart';
@HiveType(typeId: 3)
class Booking extends HiveObject{
  @HiveField(0)
  int id;

  @HiveField(1)
  int rideInstanceId;

  @HiveField(2)
  int seatsBooked;

  @HiveField(3)
  String status;

  @HiveField(4)
  int userId;

  @HiveField(5)
  Rideinstance? rideInstance;

  Booking({
    required this.id,
    required this.rideInstanceId,
    required this.seatsBooked,
    required this.status,
    required this.userId,
    this.rideInstance,
  });

    factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      rideInstanceId: json['rideInstanceId'].toInt(),
      seatsBooked: json['seatsBooked'].toInt(),
      status: json['status'],
      userId: json['userId'].toInt(),
      rideInstance: json['rideInstance'] != null
          ? Rideinstance.fromJson(json['rideInstance'])
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
    };
  }

}