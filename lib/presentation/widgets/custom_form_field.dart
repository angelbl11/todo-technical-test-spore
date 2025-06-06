import 'package:flutter/material.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';

class CustomFormField<T> extends StatelessWidget {
  final String label;
  final T value;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final Widget Function(BuildContext, T?) builder;
  final bool enabled;

  const CustomFormField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.builder,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: value,
      validator: validator,
      enabled: enabled,
      builder: (FormFieldState<T> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTheme.titleMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            builder(context, field.value),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
