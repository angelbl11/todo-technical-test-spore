import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';
import 'package:todo_list_technical_test/presentation/screens/home/home_screen.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
import 'package:todo_list_technical_test/core/providers/theme_mode_adapter.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(TodoHiveModelAdapter());
  Hive.registerAdapter(PriorityAdapter());
  Hive.registerAdapter(ThemeModeAdapter());

  await Hive.openBox<TodoHiveModel>('todos');
  await Hive.openBox('theme_box');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}
