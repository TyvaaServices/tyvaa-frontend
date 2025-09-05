import 'package:hive/hive.dart';
import 'package:passenger_tyvaa/domain/entities/ride_model.dart';

part 'ride_instance.g.dart';

@HiveType(typeId: 5)
class Rideinstance extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int rideId;

  @HiveField(2)
  String rideDate;

  @HiveField(3)
  int seatsAvailable;

  @HiveField(4)
  int seatsBooked;

  @HiveField(5)
  String status;

  @HiveField(6)
  RideModel? ride;

  Rideinstance({
    required this.id,
    required this.rideId,
    required this.rideDate,
    required this.seatsAvailable,
    required this.seatsBooked,
    required this.status,
    this.ride,
  });

  factory Rideinstance.fromJson(Map<String, dynamic> json) {
    return Rideinstance(
      id: json['id'] as int,
      rideId: json['rideId'] as int,
      rideDate: json['rideDate'] as String,
      seatsAvailable: json['seatsAvailable'] as int,
      seatsBooked: json['seatsBooked'] as int,
      status: json['status'] as String,
      ride:
          json['ride'] != null
              ? RideModel.fromJson(json['ride'])
              : json['RideModel'] != null
              ? RideModel.fromJson(json['RideModel'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rideId': rideId,
      'rideDate': rideDate,
      'seatsAvailable': seatsAvailable,
      'seatsBooked': seatsBooked,
      'status': status,
      'ride': ride?.toJson(),
    };
  }
}
