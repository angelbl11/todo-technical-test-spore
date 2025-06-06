import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
import 'package:todo_list_technical_test/presentation/providers/todo_provider.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';
import 'package:todo_list_technical_test/presentation/screens/task/widgets/task_form.dart';

class TaskScreen extends ConsumerStatefulWidget {
  final Todo todo;

  const TaskScreen({
    super.key,
    required this.todo,
  });

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(taskFormNotifierProvider.notifier)
          .initializeWithTodo(widget.todo);
    });
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(taskFormNotifierProvider.notifier);
      if (notifier.isValid) {
        final updatedTodo = notifier.toTodo(
          id: widget.todo.id,
          createdAt: widget.todo.createdAt,
        );

        try {
          await ref.read(todoNotifierProvider.notifier).updateTodo(updatedTodo);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tarea actualizada correctamente'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error al guardar: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la tarea',
          style: AppTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTask,
          ),
        ],
      ),
      body: TaskFormWidget(
        formKey: _formKey,
        onSave: _saveTask,
      ),
    );
  }
}
