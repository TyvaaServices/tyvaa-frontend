// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentAdapter extends TypeAdapter<Payment> {
  @override
  final int typeId = 7;

  @override
  Payment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payment(
      transactionId: fields[0] as String,
      phone: fields[1] as String?,
      amount: fields[2] as double,
      status: fields[3] as String,
      currency: fields[4] as String?,
      paymentMethod: fields[5] as String?,
      metadata: fields[6] as String?,
      operatorId: fields[7] as String?,
      fee: fields[8] as double?,
      provider: fields[9] as String?,
      externalTransactionId: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Payment obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.transactionId)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.currency)
      ..writeByte(5)
      ..write(obj.paymentMethod)
      ..writeByte(6)
      ..write(obj.metadata)
      ..writeByte(7)
      ..write(obj.operatorId)
      ..writeByte(8)
      ..write(obj.fee)
      ..writeByte(9)
      ..write(obj.provider)
      ..writeByte(10)
      ..write(obj.externalTransactionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
