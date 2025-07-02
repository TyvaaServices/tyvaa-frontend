// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RideModelAdapter extends TypeAdapter<RideModel> {
  @override
  final int typeId = 3;

  @override
  RideModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RideModel(
      id: fields[0] as int,
      driverId: fields[1] as int,
      departure: fields[2] as String,
      destination: fields[3] as String,
      seatsAvailable: fields[4] as int,
      recurrence: (fields[5] as List?)?.cast<String>(),
      price: fields[6] as int,
      status: fields[7] as String,
      startDate: fields[8] as String,
      endDate: fields[9] as String,
      time: fields[10] as String,
      isRecurring: fields[11] as bool,
    )..driver = fields[12] as User?;
  }

  @override
  void write(BinaryWriter writer, RideModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.driverId)
      ..writeByte(2)
      ..write(obj.departure)
      ..writeByte(3)
      ..write(obj.destination)
      ..writeByte(4)
      ..write(obj.seatsAvailable)
      ..writeByte(5)
      ..write(obj.recurrence)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.startDate)
      ..writeByte(9)
      ..write(obj.endDate)
      ..writeByte(10)
      ..write(obj.time)
      ..writeByte(11)
      ..write(obj.isRecurring)
      ..writeByte(12)
      ..write(obj.driver);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
