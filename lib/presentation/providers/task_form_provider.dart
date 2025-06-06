import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_technical_test/presentation/models/task_form.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';

part 'task_form_provider.g.dart';

@riverpod
class TaskFormNotifier extends _$TaskFormNotifier {
  @override
  TaskForm build() {
    return TaskForm.initial();
  }

  void updateTitle(String value) {
    state = state.copyWith(title: TitleInput.dirty(value));
  }

  void updateDescription(String value) {
    state = state.copyWith(description: DescriptionInput.dirty(value));
  }

  void updatePriority(Priority value) {
    state = state.copyWith(priority: value);
  }

  void updateDueDate(DateTime value) {
    state = state.copyWith(dueDate: value);
  }

  void updateIsCompleted(bool value) {
    state = state.copyWith(isCompleted: value);
  }

  void initializeWithTodo(Todo todo) {
    state = TaskForm.initial(
      title: todo.title,
      description: todo.description,
      priority: todo.priority,
      dueDate: todo.dueDate,
      isCompleted: todo.isCompleted,
    );
  }

  bool get isValid => Formz.validate([state.title, state.description]);

  Todo toTodo({String? id, DateTime? createdAt}) {
    return Todo(
      id: id ?? '',
      title: state.title.value,
      description: state.description.value,
      priority: state.priority,
      dueDate: state.dueDate,
      isCompleted: state.isCompleted,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
