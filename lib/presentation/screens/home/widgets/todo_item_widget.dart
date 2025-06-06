import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/todo_provider.dart';
import 'package:todo_list_technical_test/presentation/screens/task/task_screen.dart';

class TodoItemWidget extends ConsumerWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => onDelete(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskScreen(todo: todo),
              ),
            );
            // Recargar los datos cuando se regresa de la pantalla de edición
            await ref.read(todoNotifierProvider.notifier).build();
          },
          child: ListTile(
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) => onToggle(),
            ),
            title: Text(
              todo.title,
              style: AppTheme.headlineMedium.copyWith(
                decoration:
                    todo.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(todo.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ),
        ),
      ),
    );
  }
}
