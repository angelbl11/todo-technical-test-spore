import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';

class PriorityField extends ConsumerWidget {
  const PriorityField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(taskFormNotifierProvider);
    final notifier = ref.read(taskFormNotifierProvider.notifier);

    return DropdownButtonFormField<Priority>(
      value: formState.priority,
      decoration: const InputDecoration(
        labelText: 'Prioridad',
        border: OutlineInputBorder(),
      ),
      items: Priority.values
          .map((priority) => DropdownMenuItem(
                value: priority,
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: priority.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      priority.label,
                      style: AppTheme.bodyMedium,
                    ),
                  ],
                ),
              ))
          .toList(),
      onChanged: (value) =>
          value != null ? notifier.updatePriority(value) : null,
    );
  }
}
