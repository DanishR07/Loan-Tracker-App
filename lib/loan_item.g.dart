// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoanItemAdapter extends TypeAdapter<LoanItem> {
  @override
  final int typeId = 0;

  @override
  LoanItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoanItem(
      fields[1] as String,
      fields[2] as int,
      isReturned: fields[3] as bool,
    )..id = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, LoanItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.personName)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.isReturned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoanItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
