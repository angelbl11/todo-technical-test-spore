import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/providers/theme_provider.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/todo_provider.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/add_task_bottom_sheet.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/todo_item_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }

  Future<void> _refreshData() async {
    await ref.read(todoNotifierProvider.notifier).build();
  }

  @override
  Widget build(BuildContext context) {
    final todoStateAsync = ref.watch(todoNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis tareas',
          style: AppTheme.headlineMedium,
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(appThemeModeProvider);
              return IconButton(
                icon: Icon(
                  themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () {
                  ref.read(appThemeModeProvider.notifier).toggle();
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      body: todoStateAsync.when(
        data: (todoState) {
          if (todoState.todos.isEmpty) {
            return const Center(child: Text('No hay tareas'));
          }
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: todoState.todos.length,
              itemBuilder: (context, index) {
                final todo = todoState.todos[index];
                return TodoItemWidget(
                  todo: todo,
                  onToggle: () => ref
                      .read(todoNotifierProvider.notifier)
                      .toggleTodoCompletion(todo.id),
                  onDelete: () => ref
                      .read(todoNotifierProvider.notifier)
                      .deleteTodo(todo.id),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
