import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 4;

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
