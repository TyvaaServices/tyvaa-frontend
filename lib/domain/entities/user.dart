import 'package:hive/hive.dart';
import 'package:passenger_tyvaa/domain/entities/driver_profile.dart';
import 'package:passenger_tyvaa/domain/entities/passenger_profile.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? phoneNumber;

  @HiveField(2)
  String? fullName;

  @HiveField(3)
  String? fcmToken;

  @HiveField(4)
  String? profileImage;

  @HiveField(5)
  String? sexe;

  @HiveField(6)
  DateTime? dateOfBirth;

  @HiveField(7)
  String? email;

  @HiveField(8)
  bool? isActive;

  @HiveField(9)
  bool? isBlocked;

  @HiveField(10)
  double? latitude;

  @HiveField(11)
  double? longitude;

  @HiveField(12)
  DateTime? lastLogin;

  @HiveField(13)
  DateTime? createdAt;

  @HiveField(14)
  DateTime? updatedAt;

  @HiveField(15)
  PassengerProfile? passengerProfile;

  @HiveField(16)
  DriverProfile? driverProfile;

  @HiveField(17)
  bool? isOnline;

  @HiveField(18)
  bool? isDriver;

  @HiveField(19)
  bool? isVerified;

  @HiveField(20)
  String? driverLicense;

  @HiveField(21)
  String? carImage;

  User({
    this.id,
    this.phoneNumber,
    this.fullName,
    this.fcmToken,
    this.profileImage,
    this.sexe,
    this.dateOfBirth,
    this.email,
    this.isActive,
    this.isBlocked,
    this.latitude,
    this.longitude,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.passengerProfile,
    this.driverProfile,
    // Legacy fields
    this.isOnline,
    this.isDriver,
    this.isVerified,
    this.driverLicense,
    this.carImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      fullName: json['fullName'],
      fcmToken: json['fcmToken'],
      profileImage: json['profileImage'],
      sexe: json['sexe'],
      dateOfBirth:
          json['dateOfBirth'] != null
              ? DateTime.parse(json['dateOfBirth'])
              : null,
      email: json['email'],
      isActive: json['isActive'],
      isBlocked: json['isBlocked'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      lastLogin:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      passengerProfile:
          json['passengerProfile'] != null
              ? PassengerProfile.fromJson(json['passengerProfile'])
              : null,
      driverProfile:
          json['driverProfile'] != null
              ? DriverProfile.fromJson(json['driverProfile'])
              : null,
      // Legacy fields for backward compatibility
      isOnline: json['isOnline'],
      isDriver: json['isDriver'],
      isVerified: json['isVerified'],
      driverLicense: json['driverLicense'],
      carImage: json['carImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'fcmToken': fcmToken,
      'profileImage': profileImage,
      'sexe': sexe,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'email': email,
      'isActive': isActive,
      'isBlocked': isBlocked,
      'latitude': latitude,
      'longitude': longitude,
      'lastLogin': lastLogin?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'passengerProfile': passengerProfile?.toJson(),
      'driverProfile': driverProfile?.toJson(),
      // Legacy fields
      'isOnline': isOnline,
      'isDriver': isDriver,
      'isVerified': isVerified,
      'driverLicense': driverLicense,
      'carImage': carImage,
    };
  }
}
