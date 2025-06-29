import 'package:hive/hive.dart';

part 'driver_profile.g.dart';

@HiveType(typeId: 2)
class DriverProfile extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  double? driverNote;

  @HiveField(2)
  String? statusProfile;

  @HiveField(3)
  int? userId;

  DriverProfile({this.id, this.driverNote, this.statusProfile, this.userId});

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    return DriverProfile(
      id: json['id'],
      driverNote: json['driverNote']?.toDouble(),
      statusProfile: json['statusProfile'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverNote': driverNote,
      'statusProfile': statusProfile,
      'userId': userId,
    };
  }
}
