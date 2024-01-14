// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImcResultModelAdapter extends TypeAdapter<ImcResultModel> {
  @override
  final int typeId = 2;

  @override
  ImcResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImcResultModel(
      weight: fields[1] as double?,
      height: fields[2] as double?,
      imc: fields[3] as double?,
      date: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ImcResultModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.imc)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImcResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
