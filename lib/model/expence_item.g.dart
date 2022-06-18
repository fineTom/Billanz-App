// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expence_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenceItemAdapter extends TypeAdapter<ExpenceItem> {
  @override
  final int typeId = 0;

  @override
  ExpenceItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenceItem(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenceItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.amout);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenceItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
