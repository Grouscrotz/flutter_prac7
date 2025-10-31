import 'package:prac5/models/word.dart';

class Topic {
  final String name;
  final List<Word> words;
  bool selected;

  Topic({required this.name, required this.words, this.selected = false});
}