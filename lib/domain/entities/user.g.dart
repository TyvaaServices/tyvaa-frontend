// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      phoneNumber: fields[1] as String,
      isOnline: fields[2] as bool,
      isDriver: fields[3] as bool,
      isVerified: fields[4] as bool,
      isBlocked: fields[5] as bool,
      createdAt: fields[15] as DateTime,
      dateOfBirth: fields[12] as DateTime,
      sexe: fields[13] as String,
      email: fields[14] as String?,
      fullName: fields[6] as String?,
      fcmToken: fields[7] as String?,
      driverLicense: fields[8] as String?,
      carImage: fields[9] as String?,
      latitude: fields[10] as double?,
      longitude: fields[11] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.isOnline)
      ..writeByte(3)
      ..write(obj.isDriver)
      ..writeByte(4)
      ..write(obj.isVerified)
      ..writeByte(5)
      ..write(obj.isBlocked)
      ..writeByte(6)
      ..write(obj.fullName)
      ..writeByte(7)
      ..write(obj.fcmToken)
      ..writeByte(8)
      ..write(obj.driverLicense)
      ..writeByte(9)
      ..write(obj.carImage)
      ..writeByte(10)
      ..write(obj.latitude)
      ..writeByte(11)
      ..write(obj.longitude)
      ..writeByte(12)
      ..write(obj.dateOfBirth)
      ..writeByte(13)
      ..write(obj.sexe)
      ..writeByte(14)
      ..write(obj.email)
      ..writeByte(15)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
