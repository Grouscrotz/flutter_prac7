import 'package:flutter/material.dart';
import 'package:prac5/models/topic.dart';
import 'package:prac5/features/learning/widgets/button.dart';
import 'package:prac5/features/learning/screens/flashcard_screen.dart';

class LearningScreen extends StatefulWidget {
  final Topic? topic;
  const LearningScreen({super.key, this.topic});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {


  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;
    if (topic == null) {
      return const Center(
        child: Text(
          'Сначала выберите словарь на экране "Словари"',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    final int repeatCount = topic.words.where((w) => w.learned).length;
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFcfd9df)),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Словарь: ${topic.name}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                LearningButton(
                  icon: Icons.play_arrow,
                  iconColor: Colors.green,
                  label: 'Учить новые слова',
                  onPressed: () => _startSession(topic, learningNew: true),
                ),
                const SizedBox(height: 16),
                LearningButton(
                  icon: Icons.refresh,
                  iconColor: Colors.orangeAccent,
                  label: 'Повторить слова',
                  counter: repeatCount,
                  onPressed: () => _startSession(topic, learningNew: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _startSession(Topic topic, {required bool learningNew}) {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (_) => FlashCardScreen(topic: topic, learningNew: learningNew),
      ),
    ).then((_) => setState(() {}));
  }
}
