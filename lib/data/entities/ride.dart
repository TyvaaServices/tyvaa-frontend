import 'package:isar_plus/isar_plus.dart';

part 'ride.g.dart';

@collection
class Ride {
  int id = -1; // Initialize with dummy, set via autoIncrement() on insert

  @Index(unique: true)
  late String remoteId; // Backend UUID

  late String villeDepart;
  late String villeArrivee;
  late int distanceKm;
  late int nombrePlaces;

  @Index()
  late String conducteurId; // Foreign Key to User.remoteId

  @Index()
  late String statut; // 'ouvert', 'STARTED', etc.

  DateTime? dateDepart;
  double? prixTotal;
  double? commission;

  // GPS Data
  double? gpsStartLat;
  double? gpsStartLong;
  DateTime? gpsStartTime;

  double? gpsEndLat;
  double? gpsEndLong;
  DateTime? gpsEndTime;

  String? routeCatalogId;

  // Rich UI Data (Mock/Display)
  String driverName = 'Conducteur';
  double driverRating = 4.8;
  String carModel = 'Toyota Corolla';
  String carImage = 'assets/images/img_car_sedan.png'; // Default placeholder
  bool isVerified = false; // Driver verification status
  bool isSanitized = true; // COVID safety indicator (Case Study)

  DateTime? createdAt;
  DateTime? updatedAt;

  Ride();

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride()
      ..remoteId = json['id'] as String
      ..villeDepart = json['villeDepart'] as String
      ..villeArrivee = json['villeArrivee'] as String
      ..distanceKm = json['distanceKm'] as int
      ..nombrePlaces = json['nombrePlaces'] as int
      ..conducteurId = json['conducteurId'] as String
      ..statut = json['statut'] as String
      ..dateDepart = DateTime.tryParse(json['dateDepart'] ?? '')
      ..prixTotal = (json['prixTotal'] as num?)?.toDouble()
      ..commission = (json['commission'] as num?)?.toDouble()
      ..driverName = json['driverName'] as String? ?? 'Conducteur Tyvaa'
      ..driverRating = (json['driverRating'] as num?)?.toDouble() ?? 4.8
      ..carModel = json['carModel'] as String? ?? 'Véhicule Standard'
      ..carImage =
          json['carImage'] as String? ?? 'assets/images/img_car_sedan.png'
      ..isVerified = json['isVerified'] as bool? ?? false
      ..isSanitized = json['isSanitized'] as bool? ?? true
      ..gpsStartLat = (json['gpsStartLat'] as num?)?.toDouble()
      ..gpsStartLong = (json['gpsStartLong'] as num?)?.toDouble()
      ..gpsStartTime = DateTime.tryParse(json['gpsStartTime'] ?? '')
      ..gpsEndLat = (json['gpsEndLat'] as num?)?.toDouble()
      ..gpsEndLong = (json['gpsEndLong'] as num?)?.toDouble()
      ..gpsEndTime = DateTime.tryParse(json['gpsEndTime'] ?? '')
      ..routeCatalogId = json['routeCatalogId'] as String?
      ..createdAt = DateTime.tryParse(json['createdAt'] ?? '')
      ..updatedAt = DateTime.tryParse(json['updatedAt'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': remoteId,
      'villeDepart': villeDepart,
      'villeArrivee': villeArrivee,
      'distanceKm': distanceKm,
      'nombrePlaces': nombrePlaces,
      'conducteurId': conducteurId,
      'statut': statut,
      'dateDepart': dateDepart?.toIso8601String(),
      'prixTotal': prixTotal,
      'commission': commission,
      'gpsStartLat': gpsStartLat,
      'gpsStartLong': gpsStartLong,
      'gpsStartTime': gpsStartTime?.toIso8601String(),
      'gpsEndLat': gpsEndLat,
      'gpsEndLong': gpsEndLong,
      'gpsEndTime': gpsEndTime?.toIso8601String(),
      'routeCatalogId': routeCatalogId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
