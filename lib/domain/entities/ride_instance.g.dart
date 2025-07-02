// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_instance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RideinstanceAdapter extends TypeAdapter<Rideinstance> {
  @override
  final int typeId = 3;

  @override
  Rideinstance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rideinstance(
      id: fields[0] as int,
      rideId: fields[1] as int,
      rideDate: fields[2] as String,
      seatsAvailable: fields[3] as int,
      seatsBooked: fields[4] as int,
      status: fields[5] as String,
      ride: fields[6] as RideModel?,
    );
  }

  @override
  void write(BinaryWriter writer, Rideinstance obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rideId)
      ..writeByte(2)
      ..write(obj.rideDate)
      ..writeByte(3)
      ..write(obj.seatsAvailable)
      ..writeByte(4)
      ..write(obj.seatsBooked)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.ride);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideinstanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
