import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/models/task_form.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';
import 'package:todo_list_technical_test/presentation/widgets/custom_form_field.dart';

class TitleField extends ConsumerStatefulWidget {
  final TextEditingController controller;

  const TitleField({
    super.key,
    required this.controller,
  });

  @override
  ConsumerState<TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends ConsumerState<TitleField> {
  @override
  void initState() {
    super.initState();
    _updateControllerText();
  }

  @override
  void didUpdateWidget(TitleField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _updateControllerText();
    }
  }

  void _updateControllerText() {
    final formState = ref.read(taskFormNotifierProvider);
    if (widget.controller.text != formState.title.value) {
      widget.controller.text = formState.title.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(taskFormNotifierProvider);
    final notifier = ref.read(taskFormNotifierProvider.notifier);

    if (widget.controller.text != formState.title.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateControllerText();
      });
    }

    return CustomFormField<String>(
      label: 'Título',
      value: formState.title.value,
      onChanged: (value) => value != null ? notifier.updateTitle(value) : null,
      validator: (value) => formState.title.errorMessage,
      builder: (context, value) => TextFormField(
        controller: widget.controller,
        style: AppTheme.bodyMedium,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        onChanged: notifier.updateTitle,
      ),
    );
  }
}
