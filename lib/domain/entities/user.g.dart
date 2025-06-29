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
      id: fields[0] as int?,
      phoneNumber: fields[1] as String?,
      fullName: fields[2] as String?,
      fcmToken: fields[3] as String?,
      profileImage: fields[4] as String?,
      sexe: fields[5] as String?,
      dateOfBirth: fields[6] as DateTime?,
      email: fields[7] as String?,
      isActive: fields[8] as bool?,
      isBlocked: fields[9] as bool?,
      latitude: fields[10] as double?,
      longitude: fields[11] as double?,
      lastLogin: fields[12] as DateTime?,
      createdAt: fields[13] as DateTime?,
      updatedAt: fields[14] as DateTime?,
      passengerProfile: fields[15] as PassengerProfile?,
      driverProfile: fields[16] as DriverProfile?,
      isOnline: fields[17] as bool?,
      isDriver: fields[18] as bool?,
      isVerified: fields[19] as bool?,
      driverLicense: fields[20] as String?,
      carImage: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.fcmToken)
      ..writeByte(4)
      ..write(obj.profileImage)
      ..writeByte(5)
      ..write(obj.sexe)
      ..writeByte(6)
      ..write(obj.dateOfBirth)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.isBlocked)
      ..writeByte(10)
      ..write(obj.latitude)
      ..writeByte(11)
      ..write(obj.longitude)
      ..writeByte(12)
      ..write(obj.lastLogin)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.passengerProfile)
      ..writeByte(16)
      ..write(obj.driverProfile)
      ..writeByte(17)
      ..write(obj.isOnline)
      ..writeByte(18)
      ..write(obj.isDriver)
      ..writeByte(19)
      ..write(obj.isVerified)
      ..writeByte(20)
      ..write(obj.driverLicense)
      ..writeByte(21)
      ..write(obj.carImage);
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
