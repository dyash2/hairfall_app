import 'package:app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class InstructionCard extends StatelessWidget {
  final String title;
  final List<String> descriptions;

  const InstructionCard({
    super.key,
    required this.title,
    required this.descriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.glassWhite.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ...descriptions.map(
              (desc) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  "• $desc",
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
