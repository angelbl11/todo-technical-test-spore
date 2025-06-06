import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  static const _themeBoxName = 'theme_box';
  static const _themeKey = 'theme_mode';

  @override
  ThemeMode build() {
    final box = Hive.box(_themeBoxName);
    return box.get(_themeKey, defaultValue: ThemeMode.light) as ThemeMode;
  }

  void toggle() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newMode;
    final box = Hive.box(_themeBoxName);
    box.put(_themeKey, newMode);
  }
}
