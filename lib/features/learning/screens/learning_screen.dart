import 'package:flutter/material.dart';
import 'package:prac5/data/topics_data.dart';
import 'package:prac5/features/learning/widgets/button.dart';
import 'package:prac5/features/learning/screens/flashcard_screen.dart';
import 'package:prac5/features/dictionaries/screens/dictionaries_screen.dart';
import 'package:prac5/features/progress/screens/progress_screen.dart';

import '../../../models/topic.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DictionariesScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProgressScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Изучение')),
      body: ValueListenableBuilder<List<Topic>>(
        valueListenable: TopicsData.topicsNotifier,
        builder: (context, topics, child) {
          if (topics.isEmpty) {
            return const Center(child: Text('Нет словарей'));
          }
          final topic = topics.firstWhere((t) => t.selected, orElse: () => topics.first);
          final newCount = topic.words.where((w) => !w.learned).length;
          final repeatCount = topic.words.where((w) => w.learned).length;

          return Container(
            color: const Color(0xFFcfd9df),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Словарь: ${topic.name}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      LearningButton(
                        icon: Icons.play_arrow,
                        iconColor: Colors.green,
                        label: 'Учить новые слова',
                        counter: newCount,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => FlashCardScreen(topic: topic, learningNew: true)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      LearningButton(
                        icon: Icons.refresh,
                        iconColor: Colors.orangeAccent,
                        label: 'Повторить слова',
                        counter: repeatCount,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => FlashCardScreen(topic: topic, learningNew: false)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Словари'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Изучение'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Прогресс'),
        ],
      ),
    );
  }
}