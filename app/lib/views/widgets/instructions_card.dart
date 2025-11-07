import 'package:flutter/material.dart';

class InstructionsCard extends StatelessWidget {
  const InstructionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // light background
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Instructions",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  InstructionItem(text: "Read each question carefully."),
                  InstructionItem(text: "Select only one option per question."),
                  InstructionItem(text: "You can go back to previous questions."),
                  InstructionItem(text: "Press Submit after completing all questions."),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to quiz or next screen
                    Navigator.pushNamed(context, '/quiz');
                  },
                  child: const Text("Start Quiz"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructionItem extends StatelessWidget {
  final String text;
  const InstructionItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 18),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
