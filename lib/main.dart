import 'package:flutter/material.dart';
import 'package:prac5/features/dictionaries/screens/dictionaries_screen.dart';
import 'package:go_router/go_router.dart';

import 'features/learning/screens/flashcard_screen.dart';
import 'features/learning/screens/learning_screen.dart';
import 'features/learning/screens/topic_settings_screen.dart';
import 'features/learning/screens/word_preview_screen.dart';
import 'features/progress/screens/progress_screen.dart';
import 'models/topic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = GoRouter(
    initialLocation: '/dictionaries',
    routes: [
      GoRoute(
        path: '/dictionaries',
        builder: (context, state) => const DictionariesScreen(),
      ),
      GoRoute(
        path: '/learning',
        builder: (context, state) => const LearningScreen(),
      ),
      GoRoute(
        path: '/progress',
        builder: (context, state) => const ProgressScreen(),
      ),
      GoRoute(
        path: '/topic_settings',
        builder: (context, state) => const TopicSettingsScreen(),
      ),
      GoRoute(
        path: '/word_preview',
        builder: (context, state) => const WordPreviewScreen(),
      ),
      GoRoute(
        path: '/flashcard',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return FlashCardScreen(
            topic: extra['topic'] as Topic,
            learningNew: extra['learningNew'] as bool,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Приложение для изучения иностранных слов',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );

}