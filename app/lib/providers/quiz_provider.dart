import 'package:flutter/material.dart';
import '../data/models/quiz_question_model.dart';
import '../data/services/api_service.dart';

class QuizProvider extends ChangeNotifier {
  List<QuizQuestionModel> questions = [];
  Map<String, String> selected = {}; // Selected answers by question id
  int index = 0;
  List<String> result = []; // Optional for recommendations

  Future<void> fetchQuestions() async {
    questions = await ApiService.fetchQuiz();
    notifyListeners();
  }

  void pickOption(String qId, String optKey) {
    selected[qId] = optKey;
    notifyListeners();
  }

  void next() {
    if (index < questions.length - 1) {
      index++;
      notifyListeners();
    }
  }

  void back() {
    if (index > 0) {
      index--;
      notifyListeners();
    }
  }

  Future<void> submit() async {
    // Optional: send answers to API
    result = await ApiService.submitAnswers(selected);
    notifyListeners();
  }

  // Prepare answers in readable format for ReviewScreen
  Map<int, String> get reviewAnswers {
    final Map<int, String> map = {};
    for (int i = 0; i < questions.length; i++) {
      map[i] = selected[questions[i].id] ?? "Not answered";
    }
    return map;
  }

  // Reset quiz if neededr
  void reset() {
    selected.clear();
    index = 0;
    result.clear();
    notifyListeners();
  }
}
