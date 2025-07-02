
import 'package:hive/hive.dart';
part 'booking.g.dart';
@HiveType(typeId: 3)
class Booking extends HiveObject{
  @HiveField(0)
  int id;

  @HiveField(1)
  int rideInstanceId;

  @HiveField(2)
  int seatsBooked;

  @HiveField(3)
  String status;

  @HiveField(4)
  int userId;

  Booking({
    required this.id,
    required this.rideInstanceId,
    required this.seatsBooked,
    this.status = "booked",
    required this.userId,
  });
  
}