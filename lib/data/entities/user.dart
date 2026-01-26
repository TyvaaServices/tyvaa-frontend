import 'package:isar_plus/isar_plus.dart';

part 'user.g.dart';

@collection
class User {
  int id = -1; // Local Isar ID

  @Index(unique: true)
  late String remoteId; // Backend UUID

  late String fullName;

  @Index(unique: true)
  late String phoneNumber;

  String? email;
  String? fcmToken;
  DateTime? birthDate;
  String? sexe;

  bool isConducteurApproved = false;
  String role = 'utilisateur';

  DateTime? createdAt;
  DateTime? updatedAt;

  User();

  factory User.fromJson(Map<String, dynamic> json) {
    return User()
      ..remoteId = json['id'] as String
      ..fullName = json['fullName'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..email = json['email'] as String?
      ..fcmToken = json['fcmToken'] as String?
      ..birthDate = DateTime.tryParse(json['birthDate'] ?? '')
      ..sexe = json['sexe'] as String?
      ..isConducteurApproved = json['isConducteurApproved'] ?? false
      ..role = json['role'] ?? 'utilisateur'
      ..createdAt = DateTime.tryParse(json['createdAt'] ?? '')
      ..updatedAt = DateTime.tryParse(json['updatedAt'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': remoteId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'fcmToken': fcmToken,
      'birthDate': birthDate?.toIso8601String(),
      'sexe': sexe,
      'isConducteurApproved': isConducteurApproved,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
