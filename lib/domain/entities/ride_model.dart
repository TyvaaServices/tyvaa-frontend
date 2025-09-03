import 'package:hive/hive.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

part 'ride_model.g.dart';

@HiveType(typeId: 3)
@HiveType(typeId: 4)
class RideModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int driverId;

  @HiveField(2)
  String departure;

  @HiveField(3)
  String destination;

  @HiveField(4)
  int seatsAvailable;

  @HiveField(5)
  List<String>? recurrence;

  @HiveField(6)
  int price;

  @HiveField(7)
  String status;

  @HiveField(8)
  String startDate;

  @HiveField(9)
  String endDate;

  @HiveField(10)
  String time;

  @HiveField(11)
  bool isRecurring;

  @HiveField(12)
  User? driver;

  RideModel({
    this.id,
    required this.driverId,
    required this.departure,
    required this.destination,
    required this.seatsAvailable,
    this.recurrence,
    required this.price,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.time,
    required this.isRecurring,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      driverId: json['driverId'].toInt(),
      departure: json['departure'],
      destination: json['destination'],
      seatsAvailable: json['seatsAvailable'].toInt(),
      recurrence:
          json['recurrence'] != null
              ? List<String>.from(json['recurrence'])
              : null,
      price: json['price'].toInt(),
      status: json['status'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      time: json['time'],
      isRecurring: json['isRecurring'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverId': driverId,
      'departure': departure,
      'destination': destination,
      'seatsAvailable': seatsAvailable,
      'recurrence': recurrence,
      'price': price,
      'status': status,
      'startDate': startDate,
      'endDate': endDate,
      'time': time,
      'isRecurring': isRecurring,
    };
  }
}
