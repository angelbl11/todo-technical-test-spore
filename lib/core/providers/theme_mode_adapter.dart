import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 2; // Using typeId 2 since 0 and 1 are already used

  @override
  ThemeMode read(BinaryReader reader) {
    final value = reader.readInt();
    return ThemeMode.values[value];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeInt(obj.index);
  }
}
