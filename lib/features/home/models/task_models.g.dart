// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelsAdapter extends TypeAdapter<TaskModels> {
  @override
  final int typeId = 8;

  @override
  TaskModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModels(
      title: fields[1] as String,
      startTime: fields[2] as String,
      endTime: fields[3] as String,
      description: fields[4] as String,
      statusText: fields[5] as String,
      color: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModels obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.statusText)
      ..writeByte(6)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
