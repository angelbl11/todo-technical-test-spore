import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({
    required List<Todo> todos,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _TodoState;
}
