import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import 'app_copy.dart';
import 'app_theme.dart';

class TechnikAiApp extends StatefulWidget {
  const TechnikAiApp({super.key});

  @override
  State<TechnikAiApp> createState() => _TechnikAiAppState();
}

class _TechnikAiAppState extends State<TechnikAiApp> {
  ThemeMode _themeMode = ThemeMode.system;
  AppLanguage _language = AppLanguage.polish;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void _toggleLanguage() {
    setState(() {
      _language = _language == AppLanguage.polish
          ? AppLanguage.english
          : AppLanguage.polish;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TECHNIK AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: HomeScreen(
        language: _language,
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
        onToggleLanguage: _toggleLanguage,
      ),
    );
  }
}
