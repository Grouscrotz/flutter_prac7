import 'package:flutter/material.dart';
import 'package:prac5/features/dictionaries/screens/dictionaries_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая №7',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const DictionariesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}