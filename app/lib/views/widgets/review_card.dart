import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:app/core/themes/app_colors.dart';

class ReviewCard extends StatelessWidget {
  final int index;
  final dynamic question;
  final String selectedAnswer;
  final VoidCallback onEdit;

  const ReviewCard({
    super.key,
    required this.index,
    required this.question,
    required this.selectedAnswer,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.glassWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.glassWhiteBorder,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Q${index + 1}: ${question.title}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                selectedAnswer.isNotEmpty ? selectedAnswer : "Not answered",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
