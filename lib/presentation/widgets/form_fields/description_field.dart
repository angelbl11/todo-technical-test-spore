import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_technical_test/core/providers/speech_provider.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/models/task_form.dart';
import 'package:todo_list_technical_test/presentation/providers/task_form_provider.dart';
import 'package:todo_list_technical_test/presentation/widgets/custom_form_field.dart';

class DescriptionField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool useFormProvider;
  final bool enableVoiceInput;

  const DescriptionField({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
    this.useFormProvider = false,
    this.enableVoiceInput = false,
  });

  @override
  ConsumerState<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends ConsumerState<DescriptionField> {
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    if (widget.useFormProvider) {
      _updateControllerText();
    }
  }

  @override
  void didUpdateWidget(DescriptionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller && widget.useFormProvider) {
      _updateControllerText();
    }
  }

  void _updateControllerText() {
    final formState = ref.read(taskFormNotifierProvider);
    if (widget.controller.text != formState.description.value) {
      widget.controller.text = formState.description.value;
    }
  }

  Future<void> _startListening() async {
    try {
      final speechNotifier = ref.read(speechNotifierProvider.notifier);
      final success = await speechNotifier.startListening(
        onResult: (text) {
          if (text.isNotEmpty) {
            final currentText = widget.controller.text;
            final newText = currentText.isEmpty ? text : '$currentText $text';
            widget.controller.text = newText;
            if (widget.useFormProvider) {
              ref
                  .read(taskFormNotifierProvider.notifier)
                  .updateDescription(newText);
            } else if (widget.onChanged != null) {
              widget.onChanged!(newText);
            }
          }
        },
        onListeningComplete: () {
          if (mounted) {
            setState(() => _isListening = false);
          }
        },
      );

      if (success && mounted) {
        setState(() => _isListening = true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo iniciar el reconocimiento de voz'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _stopListening() async {
    try {
      await ref.read(speechNotifierProvider.notifier).stopListening();
      if (mounted) {
        setState(() => _isListening = false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo detener el reconocimiento de voz'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useFormProvider) {
      final formState = ref.watch(taskFormNotifierProvider);
      final notifier = ref.read(taskFormNotifierProvider.notifier);

      if (widget.controller.text != formState.description.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateControllerText();
        });
      }

      return CustomFormField<String>(
        label: 'Descripción',
        value: formState.description.value,
        onChanged: (value) =>
            value != null ? notifier.updateDescription(value) : null,
        validator: (value) => formState.description.errorMessage,
        builder: (context, value) => TextFormField(
          controller: widget.controller,
          style: AppTheme.bodyMedium,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: widget.enableVoiceInput
                ? IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        key: ValueKey<bool>(_isListening),
                        color: _isListening
                            ? Colors.red
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: _isListening ? _stopListening : _startListening,
                    tooltip: _isListening
                        ? 'Detener grabación'
                        : 'Iniciar grabación',
                  )
                : null,
          ),
          maxLines: 3,
          onChanged: notifier.updateDescription,
        ),
      );
    }

    return TextFormField(
      controller: widget.controller,
      style: AppTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: 'Descripción',
        border: const OutlineInputBorder(),
        suffixIcon: widget.enableVoiceInput
            ? IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    key: ValueKey<bool>(_isListening),
                    color: _isListening
                        ? Colors.red
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                onPressed: _isListening ? _stopListening : _startListening,
                tooltip:
                    _isListening ? 'Detener grabación' : 'Iniciar grabación',
              )
            : null,
      ),
      maxLines: 3,
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
