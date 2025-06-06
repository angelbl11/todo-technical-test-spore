import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_list_technical_test/presentation/models/task_form.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';

void main() {
  late ProviderContainer container;
  late TaskFormNotifier taskFormNotifier;

  setUp(() {
    container = ProviderContainer();
    taskFormNotifier = container.read(taskFormNotifierProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('TaskFormNotifier', () {
    test('initial state should be empty', () {
      final state = taskFormNotifier.state;

      expect(state.title.value, isEmpty);
      expect(state.description.value, isEmpty);
      expect(state.priority, Priority.medium);
      expect(state.isCompleted, false);
    });

    test('updateTitle should update title', () {
      const newTitle = 'Test Title';
      taskFormNotifier.updateTitle(newTitle);

      expect(taskFormNotifier.state.title.value, newTitle);
    });

    test('updateDescription should update description', () {
      const newDescription = 'Test Description';
      taskFormNotifier.updateDescription(newDescription);

      expect(taskFormNotifier.state.description.value, newDescription);
    });

    test('updatePriority should update priority', () {
      taskFormNotifier.updatePriority(Priority.high);

      expect(taskFormNotifier.state.priority, Priority.high);
    });

    test('updateDueDate should update due date', () {
      final newDueDate = DateTime(2024, 12, 31);
      taskFormNotifier.updateDueDate(newDueDate);

      expect(taskFormNotifier.state.dueDate, newDueDate);
    });

    test('updateIsCompleted should update completion status', () {
      taskFormNotifier.updateIsCompleted(true);

      expect(taskFormNotifier.state.isCompleted, true);
    });

    test('initializeWithTodo should set all fields from todo', () {
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        description: 'Test Description',
        priority: Priority.high,
        isCompleted: true,
        createdAt: DateTime.now(),
        dueDate: DateTime(2024, 12, 31),
      );

      taskFormNotifier.initializeWithTodo(todo);

      expect(taskFormNotifier.state.title.value, todo.title);
      expect(taskFormNotifier.state.description.value, todo.description);
      expect(taskFormNotifier.state.priority, todo.priority);
      expect(taskFormNotifier.state.dueDate, todo.dueDate);
      expect(taskFormNotifier.state.isCompleted, todo.isCompleted);
    });

    test('isValid should return true for valid form', () {
      taskFormNotifier.updateTitle('Valid Title');
      taskFormNotifier.updateDescription('Valid Description');

      expect(taskFormNotifier.isValid, true);
    });

    test('isValid should return false for invalid form', () {
      taskFormNotifier.updateTitle('');
      taskFormNotifier.updateDescription('');

      expect(taskFormNotifier.isValid, false);
    });

    test('toTodo should create Todo with correct values', () {
      const id = '1';
      final createdAt = DateTime.now();

      taskFormNotifier.updateTitle('Test Title');
      taskFormNotifier.updateDescription('Test Description');
      taskFormNotifier.updatePriority(Priority.high);
      taskFormNotifier.updateDueDate(DateTime(2024, 12, 31));
      taskFormNotifier.updateIsCompleted(true);

      final todo = taskFormNotifier.toTodo(id: id, createdAt: createdAt);

      expect(todo.id, id);
      expect(todo.title, 'Test Title');
      expect(todo.description, 'Test Description');
      expect(todo.priority, Priority.high);
      expect(todo.dueDate, DateTime(2024, 12, 31));
      expect(todo.isCompleted, true);
      expect(todo.createdAt, createdAt);
    });
  });
}
