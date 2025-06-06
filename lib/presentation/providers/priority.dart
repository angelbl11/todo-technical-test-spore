import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'priority.g.dart';

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low('Baja', Colors.green),
  @HiveField(1)
  medium('Media', Colors.orange),
  @HiveField(2)
  high('Alta', Colors.red);

  final String label;
  final Color color;
  const Priority(this.label, this.color);
}
