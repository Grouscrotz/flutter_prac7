import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac5/data/topics_data.dart';
import '../../../models/topic.dart';

class TopicSettingsScreen extends StatelessWidget {
  const TopicSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Topic>>(
      valueListenable: TopicsData.topicsNotifier,
      builder: (context, topics, child) {
        final topic = topics.firstWhere((t) => t.selected,
            orElse: () => topics.first);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Настройки словаря'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
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
                  onPressed: () => context.push('/word_preview'),
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