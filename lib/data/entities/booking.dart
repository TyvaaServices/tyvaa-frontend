import 'package:isar_plus/isar_plus.dart';

part 'booking.g.dart';

@collection
class Booking {
  int id = -1;

  @Index(unique: true)
  late String remoteId;

  @Index()
  late String passagerId; // User remoteId

  @Index()
  late String trajetId; // Ride remoteId

  late int nombrePlacesReservees;
  String statut = 'en_attente';

  double? montantTotal;
  double? prixParPassager;
  double? amountPaid;
  String? paymentMethod;

  bool paiementConducteurConfirme = false;

  int cancellationPenaltyAmount = 0;
  int refundAmount = 0;

  DateTime? cancelledAt;
  String? cancellationReason;

  DateTime? createdAt;
  DateTime? updatedAt;

  Booking();

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking()
      ..remoteId = json['id'] as String
      ..passagerId = json['passagerId'] as String
      ..trajetId = json['trajetId'] as String
      ..nombrePlacesReservees = json['nombrePlacesReservees'] as int
      ..statut = json['statut'] as String
      ..montantTotal = (json['montantTotal'] as num?)?.toDouble()
      ..prixParPassager = (json['prixParPassager'] as num?)?.toDouble()
      ..amountPaid = (json['amountPaid'] as num?)?.toDouble()
      ..paymentMethod = json['paymentMethod'] as String?
      ..paiementConducteurConfirme = json['paiementConducteurConfirme'] ?? false
      ..cancellationPenaltyAmount = json['cancellationPenaltyAmount'] ?? 0
      ..refundAmount = json['refundAmount'] ?? 0
      ..cancelledAt = DateTime.tryParse(json['cancelledAt'] ?? '')
      ..cancellationReason = json['cancellationReason'] as String?
      ..createdAt = DateTime.tryParse(json['createdAt'] ?? '')
      ..updatedAt = DateTime.tryParse(json['updatedAt'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': remoteId,
      'passagerId': passagerId,
      'trajetId': trajetId,
      'nombrePlacesReservees': nombrePlacesReservees,
      'statut': statut,
      'montantTotal': montantTotal,
      'prixParPassager': prixParPassager,
      'amountPaid': amountPaid,
      'paymentMethod': paymentMethod,
      'paiementConducteurConfirme': paiementConducteurConfirme,
      'cancellationPenaltyAmount': cancellationPenaltyAmount,
      'refundAmount': refundAmount,
      'cancelledAt': cancelledAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
