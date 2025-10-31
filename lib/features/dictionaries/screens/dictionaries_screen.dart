import 'package:flutter/material.dart';
import 'package:prac5/data/topics_data.dart';
import 'package:prac5/models/topic.dart';
import 'package:prac5/models/word.dart';
import 'package:prac5/features/dictionaries/widgets/topic_card.dart';
import 'package:prac5/features/learning/screens/learning_screen.dart';
import 'package:prac5/features/progress/screens/progress_screen.dart';

class DictionariesScreen extends StatefulWidget {
  const DictionariesScreen({super.key});

  @override
  State<DictionariesScreen> createState() => _DictionariesScreenState();
}

class _DictionariesScreenState extends State<DictionariesScreen> {
  final TextEditingController _topicController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DictionariesScreen()),
      );
    } if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LearningScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProgressScreen()),
      );
    }
  }

  void _addTopic() {
    final text = _topicController.text.trim();
    if (text.isEmpty) return;
    TopicsData.addTopic(Topic(name: text, words: []));
    _topicController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Словари')),
      body: ValueListenableBuilder<List<Topic>>(
        valueListenable: TopicsData.topicsNotifier,
        builder: (context, topics, child) {
          return Container(
            color: const Color(0xFFbac3c8),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    hintText: 'Новый словарь',
                    suffixIcon: IconButton(icon: const Icon(Icons.add), onPressed: _addTopic),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      return TopicCard(
                        topic: topic,
                        selected: topic.selected,
                        onTap: () => TopicsData.selectTopic(topic),
                        onResetProgress: () {
                          for (var w in topic.words) w.learned = false;
                          TopicsData.notifyUpdate();
                        },
                        onShowWords: () => _showWordsDialog(topic),
                        onAddWord: () => _showAddWordDialog(topic),
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

  void _showAddWordDialog(Topic topic) {
    final wordCtrl = TextEditingController();
    final transCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Добавить в "${topic.name}"'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: wordCtrl, decoration: const InputDecoration(labelText: 'Слово')),
            TextField(controller: transCtrl, decoration: const InputDecoration(labelText: 'Перевод')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              if (wordCtrl.text.isNotEmpty && transCtrl.text.isNotEmpty) {
                topic.words.add(Word(word: wordCtrl.text, translation: transCtrl.text));
                TopicsData.notifyUpdate();
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showWordsDialog(Topic topic) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(topic.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: topic.words.length,
                  itemBuilder: (_, i) {
                    final w = topic.words[i];
                    return ListTile(
                      title: Text(w.word),
                      subtitle: Text(w.translation),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          topic.words.removeAt(i);
                          TopicsData.notifyUpdate();
                          Navigator.pop(context);
                          _showWordsDialog(topic);
                        },
                      ),
                    );
                  },
                ),
              ),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Закрыть')),
            ],
          ),
        ),
      ),
    );
  }
}