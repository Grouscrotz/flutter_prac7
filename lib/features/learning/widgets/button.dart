import 'package:flutter/material.dart';

class LearningButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onPressed;
  final int? counter;

  const LearningButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onPressed,
    this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        onPressed: onPressed,
        child: Row(children: [Icon(icon, color: iconColor),
            const SizedBox(width: 12),
            Expanded(child: Text(label,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            if (counter != null) Text('$counter',
                style: const TextStyle(color: Colors.black87, fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}