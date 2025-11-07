import 'dart:developer';

import 'package:app/firebase_options.dart';
import 'package:app/providers/quiz_provider.dart';
import 'package:app/views/screens/quiz_screen.dart';
import 'package:app/views/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final userCredential = await FirebaseAuth.instance.signInAnonymously();
  log("✅ Anonymous login success. UID: ${userCredential.user?.uid}");
  runApp(
    ChangeNotifierProvider(create: (context) => QuizProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}
