import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_theme.dart';
import 'package:todo/features/todo/presentation/screens/todo_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.themeData,
      home: TodoScreen(),
    );
  }
}
