import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String phoneNumber;

  @HiveField(2)
  bool isOnline;

  @HiveField(3)
  bool isDriver;

  @HiveField(4)
  bool isVerified;

  @HiveField(5)
  bool isBlocked;

  @HiveField(6)
  String? fullName;

  @HiveField(7)
  String? fcmToken;

  @HiveField(8)
  String? driverLicense;

  @HiveField(9)
  String? carImage;

  @HiveField(10)
  double? latitude;

  @HiveField(11)
  double? longitude;

  @HiveField(12)
  final DateTime dateOfBirth;

  @HiveField(13)
  final String sexe;

  @HiveField(14)
  final String? email;

  @HiveField(15)
  final DateTime createdAt;

  User({
    required this.id,
    required this.phoneNumber,
    required this.isOnline,
    required this.isDriver,
    required this.isVerified,
    required this.isBlocked,
    required this.createdAt,
    required this.dateOfBirth,
    required this.sexe,
    this.email,
    this.fullName,
    this.fcmToken,
    this.driverLicense,
    this.carImage,
    this.latitude,
    this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      isOnline: json['isOnline'],
      isDriver: json['isDriver'],
      isVerified: json['isVerified'],
      isBlocked: json['isBlocked'],
      fullName: json['fullName'],
      fcmToken: json['fcmToken'],
      driverLicense: json['driverLicense'],
      carImage: json['carImage'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      sexe: json['sexe'],
      email: json['email'],
      latitude:
          json['latitude'] != null
              ? (json['latitude'] as num).toDouble()
              : null,
      longitude:
          json['longitude'] != null
              ? (json['longitude'] as num).toDouble()
              : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'isDriver': isDriver,
      'isVerified': isVerified,
      'isBlocked': isBlocked,
      'nomComplet': fullName,
      'fcmToken': fcmToken,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'sexe': sexe,
      'email': email,
      'driverLicense': driverLicense,
      'carImage': carImage,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
