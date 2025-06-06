import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
import 'package:todo_list_technical_test/presentation/providers/todo_provider.dart';
import 'package:todo_list_technical_test/presentation/widgets/form_fields/description_field.dart';
import 'package:todo_list_technical_test/presentation/widgets/form_fields/due_date_field.dart';
import 'package:todo_list_technical_test/presentation/widgets/form_fields/priority_field.dart';
import 'package:todo_list_technical_test/presentation/widgets/form_fields/title_field.dart';
import 'package:todo_list_technical_test/presentation/screens/task/widgets/attachments_field.dart';

class AddTaskBottomSheet extends ConsumerStatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  ConsumerState<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends ConsumerState<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Priority _priority = Priority.medium;
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  List<Attachment> _attachments = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El título es requerido';
    }
    if (value.trim().length < 3) {
      return 'El título debe tener al menos 3 caracteres';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La descripción es requerida';
    }
    if (value.trim().length < 10) {
      return 'La descripción debe tener al menos 10 caracteres';
    }
    return null;
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      ref.read(todoNotifierProvider.notifier).addTodo(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            priority: _priority,
            dueDate: _dueDate,
            attachments: _attachments,
          );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nueva tarea',
                  style: AppTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(
                        controller: _titleController,
                        validator: _validateTitle,
                      ),
                      const SizedBox(height: 16),
                      DescriptionField(
                        controller: _descriptionController,
                        validator: _validateDescription,
                      ),
                      const SizedBox(height: 16),
                      PriorityField(
                        initialValue: _priority,
                        onChanged: (value) => setState(() => _priority = value),
                      ),
                      const SizedBox(height: 16),
                      DueDateField(
                        initialDate: _dueDate,
                        onChanged: (value) => setState(() => _dueDate = value),
                      ),
                      const SizedBox(height: 16),
                      AttachmentsField(
                        attachments: _attachments,
                        onAttachmentsChanged: (attachments) {
                          setState(() => _attachments = attachments);
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _saveTask,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                        ),
                        child: Text(
                          'Crear tarea',
                          style: AppTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
