// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DriverProfileAdapter extends TypeAdapter<DriverProfile> {
  @override
  final int typeId = 2;

  @override
  DriverProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DriverProfile(
      id: fields[0] as int,
      driverNote: fields[1] as double,
      statusProfile: fields[2] as String,
      userId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DriverProfile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.driverNote)
      ..writeByte(2)
      ..write(obj.statusProfile)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
