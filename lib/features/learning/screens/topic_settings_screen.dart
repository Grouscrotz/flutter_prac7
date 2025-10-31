import 'package:flutter/material.dart';
import 'package:prac5/data/topics_data.dart';
import 'package:prac5/features/learning/screens/word_preview_screen.dart';

import '../../../models/topic.dart';

class TopicSettingsScreen extends StatelessWidget {
  const TopicSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Topic>>(
      valueListenable: TopicsData.topicsNotifier,
      builder: (context, topics, child) {
        final topic = topics.firstWhere((t) => t.selected, orElse: () => topics.first);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Настройки словаря'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          backgroundColor: const Color(0xFFcfd9df),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Название'),
                    subtitle: Text(topic.name),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    title: const Text('Всего слов'),
                    subtitle: Text('${topic.words.length}'),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WordPreviewScreen()),
                    );
                  },
                  child: const Text('Предпросмотр слов'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}