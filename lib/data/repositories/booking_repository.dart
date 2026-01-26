import 'package:isar_plus/isar_plus.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../providers/isar_provider.dart';
import '../entities/booking.dart';

abstract class IBookingRepository {
  Future<List<Booking>> getMyBookings();
  Future<Booking?> getBookingById(String remoteId);
  Future<Booking> createBooking(Booking booking);
  Future<void> updateBookingStatus(String remoteId, String status);
  Future<void> cancelBooking(String remoteId, String reason);
}

class BookingRepository extends GetxService implements IBookingRepository {
  final IsarProvider _isarProvider;

  BookingRepository(this._isarProvider);

  // MOCK SEEDING
  Future<void> _seedMockBookings() async {
    final isar = await _isarProvider.db;
    final count = isar.bookings.count();

    if (count == 0) {
      await isar.writeAsync((isar) async {
        final mockBookings = [
          Booking()
            ..remoteId = const Uuid().v4()
            ..trajetId = 'mock_ride_id_1'
            ..passagerId = 'current_user'
            ..nombrePlacesReservees = 1
            ..statut = 'confirmee'
            ..montantTotal = 5000,
          Booking()
            ..remoteId = const Uuid().v4()
            ..trajetId = 'mock_ride_id_2'
            ..passagerId = 'other_user'
            ..nombrePlacesReservees = 2
            ..statut = 'en_attente'
            ..montantTotal = 6000,
        ];

        for (var booking in mockBookings) {
          booking.id = isar.bookings.autoIncrement();
          isar.bookings.put(booking);
        }
      });
    }
  }

  @override
  Future<List<Booking>> getMyBookings() async {
    await _seedMockBookings();
    final isar = await _isarProvider.db;
    // try {
    //   final response = await _apiProvider.dio.get('/reservations/me');
    //   if (response.statusCode == 200) {
    //     final List<dynamic> data = response.data;
    //     final bookings = data.map((e) => Booking.fromJson(e)).toList();

    //     // Cache to Isar
    //     await isar.writeAsync((isar) async {
    //       for (var booking in bookings) {
    //         final existing = isar.bookings.where().remoteIdEqualTo(booking.remoteId).findFirst();
    //         if (existing != null) {
    //           booking.id = existing.id;
    //         } else {
    //           booking.id = isar.bookings.autoIncrement();
    //         }
    //         isar.bookings.put(booking);
    //       }
    //     });

    //     return bookings;
    //   }
    //   throw Exception('Failed to load bookings');
    // } catch (e) {
    return isar.bookings.where().findAllAsync();
    // }
  }

  @override
  Future<Booking?> getBookingById(String remoteId) async {
    final isar = await _isarProvider.db;
    // try {
    //   final response = await _apiProvider.dio.get('/reservations/$remoteId');
    //   if (response.statusCode == 200) {
    //     return Booking.fromJson(response.data);
    //   }
    //   return null;
    // } catch (e) {
    return isar.bookings.where().remoteIdEqualTo(remoteId).findFirst();
    // }
  }

  @override
  Future<Booking> createBooking(Booking booking) async {
    // Mock Create
    // final response = await _apiProvider.dio.post('/reservations', data: booking.toJson());
    // if (response.statusCode == 201) {
    //   final createdBooking = Booking.fromJson(response.data);

    final isar = await _isarProvider.db;
    booking.remoteId = const Uuid().v4();

    await isar.writeAsync((isar) async {
      booking.id = isar.bookings.autoIncrement();
      isar.bookings.put(booking);
    });

    await Future.delayed(const Duration(seconds: 1));
    return booking;
    // }
    // throw Exception('Failed to create booking');
  }

  @override
  Future<void> updateBookingStatus(String remoteId, String status) async {
    // await _apiProvider.dio.patch('/reservations/$remoteId', data: {'statut': status});

    // Sync local
    final isar = await _isarProvider.db;
    await isar.writeAsync((isar) async {
      final booking = isar.bookings
          .where()
          .remoteIdEqualTo(remoteId)
          .findFirst();
      if (booking != null) {
        booking.statut = status;
        isar.bookings.put(booking);
      }
    });
  }

  @override
  Future<void> cancelBooking(String remoteId, String reason) async {
    // await _apiProvider.dio.patch('/reservations/$remoteId/cancel', data: {'reason': reason});

    final isar = await _isarProvider.db;
    await isar.writeAsync((isar) async {
      final booking = isar.bookings
          .where()
          .remoteIdEqualTo(remoteId)
          .findFirst();
      if (booking != null) {
        booking.statut = 'annulee';
        booking.cancellationReason = reason;
        isar.bookings.put(booking);
      }
    });
  }
}
