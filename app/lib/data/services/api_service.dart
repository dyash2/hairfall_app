import 'dart:convert';
import 'dart:developer';
import 'package:app/core/constants/api_endpoints.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:app/data/models/quiz_question_model.dart';

class ApiService {
  static Future<List<QuizQuestionModel>> fetchQuiz() async {
    final response = await http.get(Uri.parse(ApiEndpoints.quiz));

    log("STATUS: ${response.statusCode}");
    log("HEADERS: ${response.headers}");
    log("BODY: ${response.body}");

    try {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return (json["questions"] as List)
            .map((e) => QuizQuestionModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Server returned ${response.statusCode}");
      }
    } catch (error, stack) {
      log("JSON Parse Error: $error");
      log(stack.toString());
      return [];
    }
  }

  static Future<List<QuizQuestionModel>> fetchCatalog() async {
    final response = await http.get(Uri.parse(ApiEndpoints.catalog));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data
          .map<QuizQuestionModel>((e) => QuizQuestionModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<List<String>> submitAnswers(Map<String, String> answers) async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await http.post(
      Uri.parse(ApiEndpoints.recommend),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"answers": answers, "rules_version": "v1"}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data);
    } else {
      throw Exception("Error: ${response.body}");
    }
  }
}
