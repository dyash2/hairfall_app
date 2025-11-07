import 'package:app/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recommendation_screen.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        title: const Text("Review Answers",style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.teal,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  for (var entry in provider.questions.asMap().entries)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Q${entry.key + 1}: ${entry.value.title}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              provider.selected[entry.value.id] ??
                                  "Not answered",
                              style: const TextStyle(fontSize: 15),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: () {
                                  provider.index = entry.key;
                                  Navigator.pop(
                                    context,
                                  ); // Return to QuizScreen
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.teal,
                                ),
                                label: const Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    "Disclaimer: This is not medical advice. Consult a healthcare professional if needed.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await provider.submit(); // Get recommendation from backend
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RecommendationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Get Recommendation",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
