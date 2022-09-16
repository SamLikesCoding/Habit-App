// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivityModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityModelAdapter extends TypeAdapter<ActivityModel> {
  @override
  final int typeId = 0;

  @override
  ActivityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as bool,
      fields[3] as bool,
    )..record = (fields[4] as List).cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, ActivityModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.actName)
      ..writeByte(2)
      ..write(obj.isCount)
      ..writeByte(3)
      ..write(obj.isTimed)
      ..writeByte(4)
      ..write(obj.record);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
