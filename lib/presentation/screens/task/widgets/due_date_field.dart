import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';

class DueDateField extends ConsumerWidget {
  const DueDateField({super.key});

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final formState = ref.read(taskFormNotifierProvider);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: formState.dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != formState.dueDate) {
      ref.read(taskFormNotifierProvider.notifier).updateDueDate(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(taskFormNotifierProvider);

    return InkWell(
      onTap: () => _selectDate(context, ref),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Fecha de vencimiento',
          border: OutlineInputBorder(),
        ),
        child: Text(
          '${formState.dueDate.day}/${formState.dueDate.month}/${formState.dueDate.year}',
          style: AppTheme.bodyMedium,
        ),
      ),
    );
  }
}
