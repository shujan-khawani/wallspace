import 'package:flutter/material.dart';
import 'package:wallspace/theme/themes.dart';
import 'package:wallspace/view/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wall Space',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const HomePage(),
    );
  }
}
