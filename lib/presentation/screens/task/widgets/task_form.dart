import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/screens/task/widgets/description_field.dart';
import 'package:todo_list_technical_test/presentation/screens/task/widgets/due_date_field.dart';
import 'package:todo_list_technical_test/presentation/screens/task/widgets/priority_field.dart';
import 'package:todo_list_technical_test/presentation/screens/task/widgets/title_field.dart';

class TaskFormWidget extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;

  const TaskFormWidget({
    super.key,
    required this.formKey,
    required this.onSave,
  });

  @override
  ConsumerState<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends ConsumerState<TaskFormWidget> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(taskFormNotifierProvider);
    final notifier = ref.read(taskFormNotifierProvider.notifier);

    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleField(controller: _titleController),
            const SizedBox(height: 16),
            DescriptionField(controller: _descriptionController),
            const SizedBox(height: 16),
            const PriorityField(),
            const SizedBox(height: 16),
            const DueDateField(),
            const SizedBox(height: 16),
            SwitchListTile(
              value: formState.isCompleted,
              onChanged: notifier.updateIsCompleted,
              title: Text(
                formState.isCompleted ? 'Completada' : 'Pendiente',
                style: AppTheme.bodyMedium,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: widget.onSave,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Text(
                'Guardar cambios',
                style: AppTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
