import 'package:hive/hive.dart';

part 'passenger_profile.g.dart';

@HiveType(typeId: 1)
class PassengerProfile extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  double? passengerNote;

  @HiveField(2)
  int? userId;

  PassengerProfile({this.id, this.passengerNote, this.userId});

  factory PassengerProfile.fromJson(Map<String, dynamic> json) {
    return PassengerProfile(
      id: json['id'],
      passengerNote: json['passengerNote']?.toDouble(),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'passengerNote': passengerNote, 'userId': userId};
  }
}
