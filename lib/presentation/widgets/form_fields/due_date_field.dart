import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';

class DueDateField extends ConsumerWidget {
  final DateTime initialDate;
  final void Function(DateTime)? onChanged;
  final bool useFormProvider;

  const DueDateField({
    super.key,
    required this.initialDate,
    this.onChanged,
    this.useFormProvider = false,
  });

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: useFormProvider
          ? ref.read(taskFormNotifierProvider).dueDate
          : initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      if (useFormProvider) {
        ref.read(taskFormNotifierProvider.notifier).updateDueDate(picked);
      } else {
        onChanged?.call(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (useFormProvider) {
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

    return InkWell(
      onTap: () => _selectDate(context, ref),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Fecha de vencimiento',
          border: OutlineInputBorder(),
        ),
        child: Text(
          '${initialDate.day}/${initialDate.month}/${initialDate.year}',
          style: AppTheme.bodyMedium,
        ),
      ),
    );
  }
}
