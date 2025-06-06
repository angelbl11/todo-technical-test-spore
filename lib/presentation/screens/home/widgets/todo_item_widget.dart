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
      direction: DismissDirection.horizontal,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.blue,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return true;
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskScreen(todo: todo),
            ),
          );
          await ref.read(todoNotifierProvider.notifier).build();
          return false;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
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
            await ref.read(todoNotifierProvider.notifier).build();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: todo.priority.color,
                  width: 4,
                ),
              ),
            ),
            child: ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) => onToggle(),
              ),
              title: Text(
                todo.title,
                style: AppTheme.titleMedium.copyWith(
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.description,
                    style: AppTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: todo.priority.color.withAlpha(26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      todo.priority.label,
                      style: AppTheme.labelSmall.copyWith(
                        color: todo.priority.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
