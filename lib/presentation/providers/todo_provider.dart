import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
import 'package:todo_list_technical_test/presentation/providers/todo_state.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  late Box<TodoHiveModel> _todoBox;
  final _uuid = const Uuid();

  @override
  FutureOr<TodoState> build() async {
    _todoBox = Hive.box<TodoHiveModel>('todos');
    return _loadTodos();
  }

  Future<TodoState> _loadTodos() async {
    try {
      final todos =
          _todoBox.values.map((hiveModel) => hiveModel.toTodo()).toList();
      return TodoState(todos: todos);
    } catch (e) {
      return TodoState(
        todos: [],
        errorMessage: 'Error loading todos: ${e.toString()}',
      );
    }
  }

  Future<void> addTodo({
    required String title,
    required String description,
    required Priority priority,
    required DateTime dueDate,
  }) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final todo = Todo(
        id: _uuid.v4(),
        title: title,
        description: description,
        priority: priority,
        isCompleted: false,
        createdAt: DateTime.now(),
        dueDate: dueDate,
      );

      await _todoBox.put(todo.id, TodoHiveModel.fromTodo(todo));
      final updatedTodos =
          _todoBox.values.map((hiveModel) => hiveModel.toTodo()).toList();
      state = AsyncValue.data(state.value!.copyWith(
        todos: updatedTodos,
        isLoading: false,
      ));
    } catch (e) {
      state = AsyncValue.data(state.value!.copyWith(
        isLoading: false,
        errorMessage: 'Error adding todo: ${e.toString()}',
      ));
    }
  }

  Future<void> updateTodo(Todo todo) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      await _todoBox.put(todo.id, TodoHiveModel.fromTodo(todo));
      final updatedTodos =
          _todoBox.values.map((hiveModel) => hiveModel.toTodo()).toList();
      state = AsyncValue.data(state.value!.copyWith(
        todos: updatedTodos,
        isLoading: false,
      ));
    } catch (e) {
      state = AsyncValue.data(state.value!.copyWith(
        isLoading: false,
        errorMessage: 'Error updating todo: ${e.toString()}',
      ));
    }
  }

  Future<void> deleteTodo(String id) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      await _todoBox.delete(id);
      final updatedTodos =
          _todoBox.values.map((hiveModel) => hiveModel.toTodo()).toList();
      state = AsyncValue.data(state.value!.copyWith(
        todos: updatedTodos,
        isLoading: false,
      ));
    } catch (e) {
      state = AsyncValue.data(state.value!.copyWith(
        isLoading: false,
        errorMessage: 'Error deleting todo: ${e.toString()}',
      ));
    }
  }

  Future<void> toggleTodoCompletion(String id) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final todoHiveModel = _todoBox.get(id);
      if (todoHiveModel != null) {
        final todo = todoHiveModel.toTodo();
        final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
        await _todoBox.put(id, TodoHiveModel.fromTodo(updatedTodo));
        final updatedTodos =
            _todoBox.values.map((hiveModel) => hiveModel.toTodo()).toList();
        state = AsyncValue.data(state.value!.copyWith(
          todos: updatedTodos,
          isLoading: false,
        ));
      }
    } catch (e) {
      state = AsyncValue.data(state.value!.copyWith(
        isLoading: false,
        errorMessage: 'Error toggling todo completion: ${e.toString()}',
      ));
    }
  }
}
