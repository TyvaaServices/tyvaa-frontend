import 'package:isar_plus/isar_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../entities/user.dart';
import '../entities/ride.dart';
import '../entities/booking.dart';

class IsarProvider {
  late Future<Isar> db;

  IsarProvider() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      schemas: [UserSchema, RideSchema, BookingSchema],
      directory: dir.path,
      inspector: true,
    );
  }
}
