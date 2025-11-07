import 'dart:developer';

import 'package:app/providers/quiz_provider.dart';
import 'package:app/views/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'review_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PageController _pageController;

@override
void initState() {
  super.initState();
  _pageController = PageController();

  Future.microtask(() {
    final user = FirebaseAuth.instance.currentUser;
    log("🔐 Logged in as: ${user?.uid}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Logged in anonymously")),
    );

    Provider.of<QuizProvider>(context, listen: false).fetchQuestions();
  });
}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hairfall Questionnaire")),
      body: Consumer<QuizProvider>(
        builder: (context, provider, _) {
          if (provider.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: provider.questions.length,
                  onPageChanged: (page) => provider.index = page,
                  itemBuilder: (context, index) {
                    final question = provider.questions[index];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Q${index + 1}. ${question.title}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ...question.options.map((opt) {
                            return GestureDetector(
                              onTap: () =>
                                  provider.pickOption(question.id, opt.key),
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: opt.key,
                                    groupValue: provider.selected[question.id],
                                    onChanged: (val) =>
                                        provider.pickOption(question.id, val!),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    opt.label,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: provider.questions.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.red,
                    dotColor: Colors.red.withOpacity(0.5),
                    dotHeight: 12,
                    dotWidth: 12,
                    spacing: 5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (provider.index > 0)
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            provider.back();
                          },
                          text: "← Back",
                        ),
                      ),
                    if (provider.index > 0) const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        onPressed:
                            provider.selected[provider
                                    .questions[provider.index]
                                    .id] ==
                                null
                            ? null
                            : () {
                                if (provider.index ==
                                    provider.questions.length - 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ReviewScreen(),
                                    ),
                                  );
                                } else {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                  provider.next();
                                }
                              },
                        text: provider.index == provider.questions.length - 1
                            ? "Submit"
                            : "Next →",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.info_outline, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              "Instructions",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "• This quiz has 5 questions to help estimate the primary cause of hair fall.",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "• Select the option that best describes your habits or condition.",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "• Your answers are not medical advice but provide personalized recommendations.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }
}
