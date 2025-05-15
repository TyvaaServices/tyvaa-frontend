// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'long_ride.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LongRideAdapter extends TypeAdapter<LongRide> {
  @override
  final int typeId = 1;

  @override
  LongRide read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LongRide(
      id: fields[0] as int,
      driverId: fields[1] as int,
      departure: fields[2] as String,
      destination: fields[3] as String,
      dateTime: fields[4] as DateTime,
      places: fields[5] as int,
      comment: fields[6] as String?,
      price: fields[7] as double,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LongRide obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.driverId)
      ..writeByte(2)
      ..write(obj.departure)
      ..writeByte(3)
      ..write(obj.destination)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.places)
      ..writeByte(6)
      ..write(obj.comment)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LongRideAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
