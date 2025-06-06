// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoHiveModelAdapter extends TypeAdapter<TodoHiveModel> {
  @override
  final int typeId = 0;

  @override
  TodoHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoHiveModel(
      id: fields[0] as String,
      description: fields[1] as String,
      title: fields[2] as String,
      priority: fields[3] as Priority,
      isCompleted: fields[4] as bool,
      createdAt: fields[5] as DateTime,
      dueDate: fields[6] as DateTime,
      attachments: (fields[7] as List?)?.cast<AttachmentHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.isCompleted)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.dueDate)
      ..writeByte(7)
      ..write(obj.attachments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttachmentHiveModelAdapter extends TypeAdapter<AttachmentHiveModel> {
  @override
  final int typeId = 1;

  @override
  AttachmentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttachmentHiveModel(
      id: fields[0] as String,
      path: fields[1] as String,
      type: fields[2] as AttachmentType,
      name: fields[3] as String,
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AttachmentHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttachmentTypeAdapter extends TypeAdapter<AttachmentType> {
  @override
  final int typeId = 2;

  @override
  AttachmentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AttachmentType.image;
      case 1:
        return AttachmentType.pdf;
      case 2:
        return AttachmentType.audio;
      default:
        return AttachmentType.image;
    }
  }

  @override
  void write(BinaryWriter writer, AttachmentType obj) {
    switch (obj) {
      case AttachmentType.image:
        writer.writeByte(0);
        break;
      case AttachmentType.pdf:
        writer.writeByte(1);
        break;
      case AttachmentType.audio:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
