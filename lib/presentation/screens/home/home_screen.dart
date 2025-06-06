import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/todo_provider.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/add_task_bottom_sheet.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/todo_item_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showAddTaskBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoStateAsync = ref.watch(todoNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis tareas',
          style: AppTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskBottomSheet(context, ref),
        child: const Icon(Icons.add),
      ),
      body: todoStateAsync.when(
        data: (todoState) {
          if (todoState.todos.isEmpty) {
            return const Center(child: Text('No hay tareas'));
          }
          return ListView.builder(
            itemCount: todoState.todos.length,
            itemBuilder: (context, index) {
              final todo = todoState.todos[index];
              return TodoItemWidget(
                todo: todo,
                onToggle: () => ref
                    .read(todoNotifierProvider.notifier)
                    .toggleTodoCompletion(todo.id),
                onDelete: () =>
                    ref.read(todoNotifierProvider.notifier).deleteTodo(todo.id),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
