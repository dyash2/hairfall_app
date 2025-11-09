import 'dart:ui';
import 'package:app/core/themes/app_colors.dart';
import 'package:app/core/utils/gradient_utils.dart';
import 'package:app/providers/quiz_provider.dart';
import 'package:app/views/widgets/appbar_widget.dart';
import 'package:app/views/widgets/primary_button.dart';
import 'package:app/views/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recommendation_screen.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TransparentAppBar(
        title: "Review Answers",
        showLeading: true,
      ),
      body: Container(
        decoration: GradientUtils.defaultBoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  for (var entry in provider.questions.asMap().entries)
                    ReviewCard(
                      index: entry.key,
                      question: entry.value,
                      selectedAnswer: provider.selected[entry.value.id] ?? "",
                      onEdit: () {
                        provider.index = entry.key;
                        Navigator.pop(context);
                      },
                    ),
                  const SizedBox(height: 20),
                  Text(
                    "Disclaimer: This is not medical advice. Consult a healthcare professional if needed.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: "Get Recommendation",
              onPressed: () async {
                await provider.submit();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RecommendationScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
