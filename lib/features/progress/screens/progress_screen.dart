import 'package:flutter/material.dart';
import 'package:prac5/data/topics_data.dart';
import 'package:prac5/features/dictionaries/screens/dictionaries_screen.dart';
import 'package:prac5/features/learning/screens/learning_screen.dart';

import '../../../models/topic.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DictionariesScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LearningScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Прогресс')),
      body: ValueListenableBuilder<List<Topic>>(
        valueListenable: TopicsData.topicsNotifier,
        builder: (context, topics, child) {
          final total = topics.expand((t) => t.words).length;
          final learned = topics.expand((t) => t.words.where((w) => w.learned)).length;
          final progress = total > 0 ? (learned / total) * 100 : 0;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text('Общий прогресс', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(value: progress / 100),
                        const SizedBox(height: 8),
                        Text('${progress.toStringAsFixed(1)}% ($learned/$total)'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: topics.length,
                    itemBuilder: (_, i) {
                      final t = topics[i];
                      final p = t.words.isEmpty ? 0 : (t.words.where((w) => w.learned).length / t.words.length) * 100;
                      return ListTile(
                        title: Text(t.name),
                        trailing: Text('${p.toInt()}%'),
                      );
                    },
                  ),
                ),
              ],
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