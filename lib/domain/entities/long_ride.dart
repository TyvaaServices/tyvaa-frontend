import 'package:hive/hive.dart';

part 'long_ride.g.dart';

@HiveType(typeId: 1)
class LongRide extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int driverId;

  @HiveField(2)
  final String departure;

  @HiveField(3)
  final String destination;

  @HiveField(4)
  final DateTime dateTime;

  @HiveField(5)
  final int places;

  @HiveField(6)
  final String? comment;

  @HiveField(7)
  final double price;

  @HiveField(8)
  final DateTime updatedAt;

  LongRide({
    required this.id,
    required this.driverId,
    required this.departure,
    required this.destination,
    required this.dateTime,
    required this.places,
    this.comment,
    required this.price,
    required this.updatedAt,
  });

  factory LongRide.fromJson(Map<String, dynamic> json) {
    return LongRide(
      id: json['id'],
      driverId: json['driverId'],
      departure: json['departure'],
      destination: json['destination'],
      dateTime: DateTime.parse(json['dateTime']),
      places: json['places'],
      comment: json['comment'],
      price: double.parse(
        json['price'].toString(),
      ), // Handle both String and num
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverId': driverId,
      'departure': departure,
      'destination': destination,
      'dateTime': dateTime.toIso8601String(),
      'places': places,
      'comment': comment,
      'price': price,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
