// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PassengerProfileAdapter extends TypeAdapter<PassengerProfile> {
  @override
  final int typeId = 1;

  @override
  PassengerProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PassengerProfile(
      id: fields[0] as int?,
      passengerNote: fields[1] as double?,
      userId: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PassengerProfile obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.passengerNote)
      ..writeByte(2)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PassengerProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
