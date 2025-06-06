import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/providers/theme_provider.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
import 'package:todo_list_technical_test/presentation/providers/todo_provider.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/add_task_bottom_sheet.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/empty_state_widget.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/filter_bottom_sheet.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/search_bar_widget.dart';
import 'package:todo_list_technical_test/presentation/screens/home/widgets/todo_item_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  Priority? _priorityFilter;
  bool? _completionFilter;
  String _sortBy = 'dueDate'; // 'dueDate', 'priority', 'title'

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterBottomSheet(
          sortBy: _sortBy,
          priorityFilter: _priorityFilter,
          completionFilter: _completionFilter,
          onSortByChanged: (value) => setState(() => _sortBy = value),
          onPriorityFilterChanged: (value) =>
              setState(() => _priorityFilter = value),
          onCompletionFilterChanged: (value) =>
              setState(() => _completionFilter = value),
        );
      },
    );
  }

  Future<void> _refreshData() async {
    await ref.read(todoNotifierProvider.notifier).build();
  }

  List<Todo> _filterAndSortTodos(List<Todo> todos) {
    var filteredTodos = todos.where((todo) {
      final matchesSearch =
          todo.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesPriority =
          _priorityFilter == null || todo.priority == _priorityFilter;
      final matchesCompletion =
          _completionFilter == null || todo.isCompleted == _completionFilter;
      return matchesSearch && matchesPriority && matchesCompletion;
    }).toList();

    switch (_sortBy) {
      case 'dueDate':
        filteredTodos.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case 'priority':
        filteredTodos
            .sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
      case 'title':
        filteredTodos.sort((a, b) => a.title.compareTo(b.title));
        break;
    }

    return filteredTodos;
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
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
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
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          Expanded(
            child: todoStateAsync.when(
              data: (todoState) {
                final filteredTodos = _filterAndSortTodos(todoState.todos);

                if (filteredTodos.isEmpty) {
                  return EmptyStateWidget(
                    hasFilters: _searchQuery.isNotEmpty ||
                        _priorityFilter != null ||
                        _completionFilter != null,
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];
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
          ),
        ],
      ),
    );
  }
}
