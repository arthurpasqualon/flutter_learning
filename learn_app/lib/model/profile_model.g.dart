// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileModelAdapter extends TypeAdapter<ProfileModel> {
  @override
  final int typeId = 0;

  @override
  ProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModel()
      ..email = fields[0] as String?
      ..birthDate = fields[1] as DateTime?
      ..yearsOfExperience = fields[2] as int?
      ..selectedPowers = (fields[3] as List).cast<String>()
      ..selectedLevel = fields[4] as String?
      ..hoursPerWeek = fields[5] as double?;
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.birthDate)
      ..writeByte(2)
      ..write(obj.yearsOfExperience)
      ..writeByte(3)
      ..write(obj.selectedPowers)
      ..writeByte(4)
      ..write(obj.selectedLevel)
      ..writeByte(5)
      ..write(obj.hoursPerWeek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
