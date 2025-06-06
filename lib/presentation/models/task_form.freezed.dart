// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskForm {
  TitleInput get title => throw _privateConstructorUsedError;
  DescriptionInput get description => throw _privateConstructorUsedError;
  Priority get priority => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Create a copy of TaskForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskFormCopyWith<TaskForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskFormCopyWith<$Res> {
  factory $TaskFormCopyWith(TaskForm value, $Res Function(TaskForm) then) =
      _$TaskFormCopyWithImpl<$Res, TaskForm>;
  @useResult
  $Res call(
      {TitleInput title,
      DescriptionInput description,
      Priority priority,
      DateTime dueDate,
      bool isCompleted});
}

/// @nodoc
class _$TaskFormCopyWithImpl<$Res, $Val extends TaskForm>
    implements $TaskFormCopyWith<$Res> {
  _$TaskFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? dueDate = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TitleInput,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as DescriptionInput,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as Priority,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskFormImplCopyWith<$Res>
    implements $TaskFormCopyWith<$Res> {
  factory _$$TaskFormImplCopyWith(
          _$TaskFormImpl value, $Res Function(_$TaskFormImpl) then) =
      __$$TaskFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TitleInput title,
      DescriptionInput description,
      Priority priority,
      DateTime dueDate,
      bool isCompleted});
}

/// @nodoc
class __$$TaskFormImplCopyWithImpl<$Res>
    extends _$TaskFormCopyWithImpl<$Res, _$TaskFormImpl>
    implements _$$TaskFormImplCopyWith<$Res> {
  __$$TaskFormImplCopyWithImpl(
      _$TaskFormImpl _value, $Res Function(_$TaskFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? dueDate = null,
    Object? isCompleted = null,
  }) {
    return _then(_$TaskFormImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TitleInput,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as DescriptionInput,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as Priority,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TaskFormImpl implements _TaskForm {
  const _$TaskFormImpl(
      {required this.title,
      required this.description,
      required this.priority,
      required this.dueDate,
      required this.isCompleted});

  @override
  final TitleInput title;
  @override
  final DescriptionInput description;
  @override
  final Priority priority;
  @override
  final DateTime dueDate;
  @override
  final bool isCompleted;

  @override
  String toString() {
    return 'TaskForm(title: $title, description: $description, priority: $priority, dueDate: $dueDate, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskFormImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, description, priority, dueDate, isCompleted);

  /// Create a copy of TaskForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskFormImplCopyWith<_$TaskFormImpl> get copyWith =>
      __$$TaskFormImplCopyWithImpl<_$TaskFormImpl>(this, _$identity);
}

abstract class _TaskForm implements TaskForm {
  const factory _TaskForm(
      {required final TitleInput title,
      required final DescriptionInput description,
      required final Priority priority,
      required final DateTime dueDate,
      required final bool isCompleted}) = _$TaskFormImpl;

  @override
  TitleInput get title;
  @override
  DescriptionInput get description;
  @override
  Priority get priority;
  @override
  DateTime get dueDate;
  @override
  bool get isCompleted;

  /// Create a copy of TaskForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskFormImplCopyWith<_$TaskFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
