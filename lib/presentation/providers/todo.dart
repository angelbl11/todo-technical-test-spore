import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@HiveType(typeId: 2)
enum AttachmentType {
  @HiveField(0)
  image,
  @HiveField(1)
  pdf,
  @HiveField(2)
  audio
}

@freezed
class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    required String path,
    required AttachmentType type,
    required String name,
    required DateTime createdAt,
  }) = _Attachment;
}

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String description,
    required String title,
    required Priority priority,
    required bool isCompleted,
    required DateTime createdAt,
    required DateTime dueDate,
    @Default([]) List<Attachment> attachments,
  }) = _Todo;
}

@HiveType(typeId: 0)
class TodoHiveModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final Priority priority;
  @HiveField(4)
  final bool isCompleted;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  final DateTime dueDate;
  @HiveField(7)
  @Default([])
  final List<AttachmentHiveModel> attachments;

  TodoHiveModel({
    required this.id,
    required this.description,
    required this.title,
    required this.priority,
    required this.isCompleted,
    required this.createdAt,
    required this.dueDate,
    List<AttachmentHiveModel>? attachments,
  }) : attachments = attachments ?? [];

  Todo toTodo() => Todo(
        id: id,
        description: description,
        title: title,
        priority: priority,
        isCompleted: isCompleted,
        createdAt: createdAt,
        dueDate: dueDate,
        attachments: attachments.map((a) => a.toAttachment()).toList(),
      );

  factory TodoHiveModel.fromTodo(Todo todo) => TodoHiveModel(
        id: todo.id,
        description: todo.description,
        title: todo.title,
        priority: todo.priority,
        isCompleted: todo.isCompleted,
        createdAt: todo.createdAt,
        dueDate: todo.dueDate,
        attachments: todo.attachments
            .map((a) => AttachmentHiveModel.fromAttachment(a))
            .toList(),
      );
}

@HiveType(typeId: 1)
class AttachmentHiveModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String path;
  @HiveField(2)
  final AttachmentType type;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final DateTime createdAt;

  AttachmentHiveModel({
    required this.id,
    required this.path,
    required this.type,
    required this.name,
    required this.createdAt,
  });

  Attachment toAttachment() => Attachment(
        id: id,
        path: path,
        type: type,
        name: name,
        createdAt: createdAt,
      );

  factory AttachmentHiveModel.fromAttachment(Attachment attachment) =>
      AttachmentHiveModel(
        id: attachment.id,
        path: attachment.path,
        type: attachment.type,
        name: attachment.name,
        createdAt: attachment.createdAt,
      );
}
