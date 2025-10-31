import 'package:flutter/material.dart';
import 'package:prac5/models/word.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final bool showTranslation;
  final VoidCallback onShowTranslation;
  final VoidCallback onShowAgain;
  final VoidCallback onRemembered;

  const WordCard({
    super.key,
    required this.word,
    required this.showTranslation,
    required this.onShowTranslation,
    required this.onShowAgain,
    required this.onRemembered,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, // Центрирование по горизонтали
          children: [
            Text(
              word.word,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (word.url != null)
              CachedNetworkImage(
                imageUrl: word.url!,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              )
            else
              Container(
                width: 200,
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text('Нет изображения')),
              ),
            if (showTranslation)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  word.translation,
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: onShowTranslation, child: const Text('Показать перевод')),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: onShowAgain,
                  child: const Text('Показать ещё раз', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: onRemembered,
                  child: const Text('Запомнил', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}