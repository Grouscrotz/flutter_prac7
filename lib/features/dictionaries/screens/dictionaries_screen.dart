import 'package:flutter/material.dart';
import 'package:prac5/models/topic.dart';
import 'package:prac5/models/word.dart';
import 'package:prac5/features/dictionaries/widgets/topic_card.dart';

class DictionariesScreen extends StatefulWidget {
  final List<Topic> topics;
  final Function(Topic) onSelectTopic;
  const DictionariesScreen({super.key, required this.topics, required this.onSelectTopic});

  @override
  State<DictionariesScreen> createState() => _DictionariesScreenState();
}

class _DictionariesScreenState extends State<DictionariesScreen> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();

  void _addTopic() {
    final text = _topicController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      widget.topics.add(Topic(name: text, words: []));
      _topicController.clear();
    });
  }

  void _addWord(Topic topic) {
    final wordText = _wordController.text.trim();
    final translationText = _translationController.text.trim();
    if (wordText.isEmpty || translationText.isEmpty) return;
    setState(() {
      topic.words.add(Word(word: wordText, translation: translationText));
      _wordController.clear();
      _translationController.clear();
    });
  }

  void _resetProgress(Topic topic) {
    setState(() {
      for (var word in topic.words) {
        word.learned = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Прогресс для "${topic.name}" сброшен!')),
    );
  }

  void _showAddWordDialog(Topic topic) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Добавить слово в "${topic.name}"'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _wordController, decoration: InputDecoration(labelText: 'Слово')),
            TextField(controller: _translationController, decoration: InputDecoration(labelText: 'Перевод')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              _addWord(topic);
              Navigator.pop(context);
            },
            child: Text('Добавить'),
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
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Слова в "${topic.name}"',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Container(
                height: 350,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: topic.words.length,
                  itemBuilder: (_, index) {
                    final word = topic.words[index];
                    return ListTile(
                      dense: true,
                      title: Text(word.word),
                      subtitle: Text(word.translation),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (word.learned)
                            Icon(Icons.check_circle, color: Colors.green, size: 20),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                topic.words.removeAt(index);
                              });
                              Navigator.pop(context);
                              _showWordsDialog(topic);
                            },
                            child: Icon(Icons.delete, color: Colors.red, size: 20),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                ),
              ),
              SizedBox(height: 16),
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Закрыть')),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFbac3c8)),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(height: 40),
          TextField(
            controller: _topicController,
            decoration: InputDecoration(
              hintText: 'Новый словарь',
              suffixIcon: IconButton(icon: Icon(Icons.add), onPressed: _addTopic),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.topics.length,
              itemBuilder: (context, index) {
                final topic = widget.topics[index];
                return TopicCard(
                  topic: topic,
                  selected: topic.selected,
                  onTap: () => widget.onSelectTopic(topic),
                  onResetProgress: () => _resetProgress(topic),
                  onShowWords: () => _showWordsDialog(topic),
                  onAddWord: () => _showAddWordDialog(topic),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  }