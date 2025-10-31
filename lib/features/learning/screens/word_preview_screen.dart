import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac5/data/topics_data.dart';
import '../../../models/topic.dart';

class WordPreviewScreen extends StatelessWidget {
  const WordPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Topic>>(
      valueListenable: TopicsData.topicsNotifier,
      builder: (context, topics, child) {
        final topic = topics.firstWhere((t) => t.selected,
            orElse: () => topics.first);
        final words = topic.words;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Предпросмотр слов'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          backgroundColor: const Color(0xFFcfd9df),
          body: words.isEmpty
              ? const Center(child: Text('Нет слов'))
              : ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(word.word),
                  subtitle: Text(word.translation),
                  trailing: word.learned
                      ? const Icon(Icons.check_circle,
                      color: Colors.green)
                      : const Icon(Icons.radio_button_unchecked),
                  onTap: () => context.push(
                    '/flashcard',
                    extra: {
                      'topic': topic,
                      'learningNew': !word.learned
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}