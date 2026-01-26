import 'package:isar_plus/isar_plus.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../providers/isar_provider.dart';
import '../entities/ride.dart';

abstract class IRideRepository {
  Future<List<Ride>> searchRides(String from, String to, DateTime date);
  Future<void> publishRide(Ride ride);
  Future<void> updateRideStatus(String remoteId, String status);
}

class RideRepository extends GetxService implements IRideRepository {
  final IsarProvider _isarProvider;

  RideRepository(this._isarProvider);

  // MOCK SEEDING (Run once)
  Future<void> _seedMockRides() async {
    final isar = await _isarProvider.db;
    final count = isar.rides.count();

    if (count == 0) {
      await isar.writeAsync((isar) async {
        final mockRides = [
          Ride()
            ..remoteId = const Uuid().v4()
            ..villeDepart = 'Dakar'
            ..villeArrivee = 'Saint-Louis'
            ..dateDepart = DateTime.now().add(const Duration(hours: 2))
            ..distanceKm = 260
            ..prixTotal = 5000
            ..nombrePlaces = 4
            ..statut = 'en_attente'
            ..conducteurId = 'driver_1',
          Ride()
            ..remoteId = const Uuid().v4()
            ..villeDepart = 'Thiès'
            ..villeArrivee = 'Dakar'
            ..dateDepart = DateTime.now().add(
              const Duration(days: 1, hours: 10),
            )
            ..distanceKm = 70
            ..prixTotal = 3000
            ..nombrePlaces = 3
            ..statut = 'en_attente'
            ..conducteurId = 'driver_2',
          Ride()
            ..remoteId = const Uuid().v4()
            ..villeDepart = 'Mbour'
            ..villeArrivee = 'Kaolack'
            ..dateDepart = DateTime.now().add(const Duration(hours: 5))
            ..distanceKm = 100
            ..prixTotal = 2000
            ..nombrePlaces = 2
            ..statut = 'en_attente'
            ..conducteurId = 'driver_3',
        ];

        for (var ride in mockRides) {
          ride.id = isar.rides.autoIncrement();
          isar.rides.put(ride);
        }
      });
    }
  }

  @override
  Future<List<Ride>> searchRides(String from, String to, DateTime date) async {
    // Ensure mock data is present
    await _seedMockRides();

    final isar = await _isarProvider.db;
    try {
      // 1. Try Online Fetch
      // Since API is likely not ready, we skip to fallback for now to show mock data
      // final response = await _apiProvider.dio.get('/trajets/search', queryParameters: ...);
      throw Exception('Force fallback to offline mock data');
    } catch (e) {
      // 2. Fallback to Isar Offline (Mock Data)
      // fetch all and filter in Dart to avoid Isar query syntax issues during prototyping
      final allRides = await isar.rides.where().findAllAsync();

      if (from.isEmpty && to.isEmpty) {
        return allRides;
      }

      return allRides.where((ride) {
        final matchFrom =
            from.isEmpty ||
            ride.villeDepart.toLowerCase().contains(from.toLowerCase());
        final matchTo =
            to.isEmpty ||
            ride.villeArrivee.toLowerCase().contains(to.toLowerCase());
        return matchFrom && matchTo;
      }).toList();
    }
  }

  @override
  Future<void> publishRide(Ride ride) async {
    // Mock Publish
    // try {
    //   final response = await _apiProvider.dio.post('/trajets', data: ride.toJson());
    //   if (response.statusCode == 201) {
    //     final createdRide = Ride.fromJson(response.data);

    final isar = await _isarProvider.db;
    await isar.writeAsync((isar) async {
      ride.id = isar.rides.autoIncrement();
      isar.rides.put(ride);
    });
    //   }
    // } catch (e) {
    //   rethrow;
    // }

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> updateRideStatus(String remoteId, String status) async {
    // Mock Update
    // await _apiProvider.dio.patch('/trajets/$remoteId', data: {'statut': status});

    final isar = await _isarProvider.db;
    await isar.writeAsync((isar) async {
      final ride = isar.rides.where().remoteIdEqualTo(remoteId).findFirst();
      if (ride != null) {
        ride.statut = status;
        isar.rides.put(ride);
      }
    });
  }
}
