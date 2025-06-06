import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    final box = Hive.box<ThemeMode>('theme_box');
    return box.get('theme_mode') ?? ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) {
    final box = Hive.box<ThemeMode>('theme_box');
    box.put('theme_mode', mode);
    state = mode;
  }
}
