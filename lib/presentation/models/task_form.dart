import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';

part 'task_form.freezed.dart';

class TitleInput extends FormzInput<String, String> {
  const TitleInput.pure() : super.pure('');
  const TitleInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    if (value.isEmpty) return 'El título es requerido';
    if (value.length < 3) return 'El título debe tener al menos 3 caracteres';
    return null;
  }
}

class DescriptionInput extends FormzInput<String, String> {
  const DescriptionInput.pure() : super.pure('');
  const DescriptionInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    if (value.isEmpty) return 'La descripción es requerida';
    if (value.length < 10) {
      return 'La descripción debe tener al menos 10 caracteres';
    }
    return null;
  }
}

extension TitleInputX on TitleInput {
  String? get errorMessage => displayError;
}

extension DescriptionInputX on DescriptionInput {
  String? get errorMessage => displayError;
}

@freezed
class TaskForm with _$TaskForm {
  const factory TaskForm({
    required TitleInput title,
    required DescriptionInput description,
    required Priority priority,
    required DateTime dueDate,
    required bool isCompleted,
    @Default([]) List<Attachment> attachments,
  }) = _TaskForm;

  factory TaskForm.initial({
    String title = '',
    String description = '',
    Priority priority = Priority.medium,
    DateTime? dueDate,
    bool isCompleted = false,
    List<Attachment> attachments = const [],
  }) {
    return TaskForm(
      title: TitleInput.dirty(title),
      description: DescriptionInput.dirty(description),
      priority: priority,
      dueDate: dueDate ?? DateTime.now().add(const Duration(days: 1)),
      isCompleted: isCompleted,
      attachments: attachments,
    );
  }
}

extension TaskFormX on TaskForm {
  bool get isValid => title.isValid && description.isValid;
}
