// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_store2.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class adapterAdapter extends TypeAdapter<adapter> {
  @override
  final int typeId = 0;

  @override
  adapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return adapter(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, adapter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.contact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is adapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
