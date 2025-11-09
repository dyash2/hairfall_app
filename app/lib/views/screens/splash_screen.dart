import 'package:app/core/themes/app_colors.dart';
import 'package:app/core/utils/gradient_utils.dart';
import 'package:app/views/screens/quiz_screen.dart';
import 'package:app/views/widgets/instructions_card.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: GradientUtils.defaultBoxDecoration(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hairfall Quiz",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 30),

                InstructionCard(
                  title: "Instructions!",
                  descriptions: [
                    "This 5-question quiz estimates likely contributors to hair fall",
                    "Suggests personalized product + lifestyle combos",
                    "Not medical advice",
                    "Make sure to answer honestly for accurate results",
                    "You can review your answers before submitting",
                  ],
                ),

                InstructionCard(
                  title: "Disclaimer",
                  descriptions: [
                    "This is general wellness guidance, not medical advice. Consult a qualified professional if needed.",
                    "Results are only indicative, not diagnostic",
                    "Follow lifestyle suggestions responsibly",
                  ],
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonGlass,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                  child: const Text(
                    "Start Quiz",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
