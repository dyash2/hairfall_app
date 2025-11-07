import 'package:app/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context, listen: true);
    final result = provider.result; // List of product IDs or names from backend

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Recommendation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: result.isEmpty
            ? const Center(child: Text("No recommendation available."))
            : Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recommended Products:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: result.map((prod) {
                          return Chip(
                            label: Text(prod),
                            backgroundColor: Colors.green.shade100,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Reassess in 6–8 weeks. This is not medical advice.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
