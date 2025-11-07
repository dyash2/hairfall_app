// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Make sure you have firebase_options.dart if using FlutterFire CLI

//   // Replace this with the custom token from your backend
//   String customToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbS9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImlhdCI6MTc2MjQ5MTgyNSwiZXhwIjoxNzYyNDk1NDI1LCJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay1mYnN2Y0BoYWlyZmFsbC1xdWl6LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwic3ViIjoiZmlyZWJhc2UtYWRtaW5zZGstZmJzdmNAaGFpcmZhbGwtcXVpei5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInVpZCI6InRlc3QtdXNlci0xMjMifQ.eVMYg_iHfpYwkvvRLMI3OiVydIYXQ-960-8lTa5BaaHSmeU96KMQoK9Q6Kf9mIL_Y5B0bAvbbDf7kUrAZmqa-ZpiGz1fN_vqdvEEPdIJmCrX9ehA-0Z1oW3Pt2ARy2_ftK7EMzVibpbhbghN7Dj8wal0eOkW-78yT42dXUEhao37_BbEDCKqZC6VaKW28rdiPVDZoom82GIqqH3UbbXIE2pyi258HAvHRG0P2Irh-rVvS668TWwbHh9NCDA1p8u0nfZiaybuQQ7E3zYHrnbl1iAKgH3mSTbJNZkHCY-RL_lGcDyxcq6pUr6odV9C0O3H2qYvOjd7dP5sQ-_Bgpxjdw";

//   // Sign in with the custom token
//   UserCredential userCredential =
//       await FirebaseAuth.instance.signInWithCustomToken(customToken);

//   // Get the ID token
//   String? idToken = await userCredential.user!.getIdToken();

//   // Log the ID token
//   log("Firebase ID Token: $idToken");
// }
