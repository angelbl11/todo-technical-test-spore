import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/presentation/models/task_form.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';
import 'package:todo_list_technical_test/presentation/widgets/custom_form_field.dart';

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

  Future<void> _selectDate(BuildContext context) async {
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
  Widget build(BuildContext context) {
    final formState = ref.watch(taskFormNotifierProvider);
    final notifier = ref.read(taskFormNotifierProvider.notifier);

    // Update controllers when form state changes
    if (_titleController.text != formState.title.value) {
      _titleController.text = formState.title.value;
    }
    if (_descriptionController.text != formState.description.value) {
      _descriptionController.text = formState.description.value;
    }

    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField<String>(
              label: 'Título',
              value: formState.title.value,
              onChanged: (value) =>
                  value != null ? notifier.updateTitle(value) : null,
              validator: (value) => formState.title.errorMessage,
              builder: (context, value) => TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onChanged: notifier.updateTitle,
              ),
            ),
            const SizedBox(height: 16),
            CustomFormField<String>(
              label: 'Descripción',
              value: formState.description.value,
              onChanged: (value) =>
                  value != null ? notifier.updateDescription(value) : null,
              validator: (value) => formState.description.errorMessage,
              builder: (context, value) => TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                maxLines: 3,
                onChanged: notifier.updateDescription,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Priority>(
              value: formState.priority,
              decoration: const InputDecoration(
                labelText: 'Prioridad',
                border: OutlineInputBorder(),
              ),
              items: Priority.values
                  .map((priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(priority.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) =>
                  value != null ? notifier.updatePriority(value) : null,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha de vencimiento',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                    '${formState.dueDate.day}/${formState.dueDate.month}/${formState.dueDate.year}'),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: formState.isCompleted,
              onChanged: notifier.updateIsCompleted,
              title: Text(formState.isCompleted ? 'Completada' : 'Pendiente'),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
