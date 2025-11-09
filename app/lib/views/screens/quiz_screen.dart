import 'dart:developer';
import 'dart:ui';
import 'package:app/core/themes/app_colors.dart';
import 'package:app/core/utils/gradient_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/providers/quiz_provider.dart';
import 'package:app/views/widgets/appbar_widget.dart';
import 'package:app/views/widgets/custom_button.dart';
import 'package:app/views/widgets/option_tile.dart';
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
      log("Logged in as: ${user?.uid}");

      SnackbarUtils.showSuccess(context, "Logged in anonymously");

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
      extendBodyBehindAppBar: true,
      appBar: const TransparentAppBar(
        title: "Hairfall Quiz",
        showLeading: false,
      ),
      body: Container(
        decoration: GradientUtils.defaultBoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            if (provider.questions.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            return Column(
              children: [
                const SizedBox(height: 100),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: provider.questions.length,
                    onPageChanged: (page) => provider.index = page,
                    itemBuilder: (context, index) {
                      final question = provider.questions[index];

                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                            child: Container(
                              padding: const EdgeInsets.all(20),
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
                                  Center(
                                    child: Text(
                                      "Q${provider.index + 1}. ${question.title}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),

                                  ...question.options.map((opt) {
                                    return OptionTile(
                                      label: opt.label,
                                      value: opt.key,
                                      groupValue:
                                          provider.selected[question.id],
                                      onTap: () => provider.pickOption(
                                        question.id,
                                        opt.key,
                                      ),
                                    );
                                  }),

                                  Center(
                                    child: SmoothPageIndicator(
                                      controller: _pageController,
                                      count: provider.questions.length,
                                      effect: ExpandingDotsEffect(
                                        activeDotColor: Colors.white,
                                        dotColor: Colors.white.withOpacity(0.4),
                                        dotHeight: 10,
                                        dotWidth: 10,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 25),

                                  Row(
                                    children: [
                                      if (provider.index > 0)
                                        Expanded(
                                          child: CustomButton(
                                            text: "Back",
                                            onPressed: () {
                                              _pageController.previousPage(
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
                                                curve: Curves.easeInOut,
                                              );
                                              provider.back();
                                            },
                                          ),
                                        ),
                                      if (provider.index > 0)
                                        const SizedBox(width: 12),
                                      Expanded(
                                        child: CustomButton(
                                          text:
                                              provider.index ==
                                                  provider.questions.length - 1
                                              ? "Submit"
                                              : "Next",
                                          onPressed:
                                              provider.selected[question.id] ==
                                                  null
                                              ? null
                                              : () {
                                                  if (provider.index ==
                                                      provider
                                                              .questions
                                                              .length -
                                                          1) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            const ReviewScreen(),
                                                      ),
                                                    );
                                                  } else {
                                                    _pageController.nextPage(
                                                      duration: const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                      curve: Curves.easeInOut,
                                                    );
                                                    provider.next();
                                                  }
                                                },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}
