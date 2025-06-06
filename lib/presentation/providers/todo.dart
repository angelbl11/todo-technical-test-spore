import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

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

  TodoHiveModel({
    required this.id,
    required this.description,
    required this.title,
    required this.priority,
    required this.isCompleted,
    required this.createdAt,
    required this.dueDate,
  });

  Todo toTodo() => Todo(
        id: id,
        description: description,
        title: title,
        priority: priority,
        isCompleted: isCompleted,
        createdAt: createdAt,
        dueDate: dueDate,
      );

  factory TodoHiveModel.fromTodo(Todo todo) => TodoHiveModel(
        id: todo.id,
        description: todo.description,
        title: todo.title,
        priority: todo.priority,
        isCompleted: todo.isCompleted,
        createdAt: todo.createdAt,
        dueDate: todo.dueDate,
      );
}
