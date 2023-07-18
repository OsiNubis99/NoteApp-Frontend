// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BodyAdapter extends TypeAdapter<Body> {
  @override
  final int typeId = 1;

  @override
  Body read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Body(
      id: fields[0] as String,
      idNota: fields[1] as String,
      text: fields[2] as String,
      image: (fields[3] as Map).cast<String, dynamic>(),
      date: fields[4] as DateTime,
      ocr: fields[5] as bool,
      offlineStatus: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Body obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idNota)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.ocr)
      ..writeByte(6)
      ..write(obj.offlineStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
