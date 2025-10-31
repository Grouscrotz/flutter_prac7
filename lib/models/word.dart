class Word {
  final String word;
  final String translation;
  final String? url;
  bool learned;

  Word({
    required this.word,
    required this.translation,
    this.url,
    this.learned = false,
  });
}