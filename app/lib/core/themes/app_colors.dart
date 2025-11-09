import 'package:flutter/material.dart';

class AppColors {
  // Background gradient (slightly softer)
  static const Color gradientStart = Color(0xFF009688); // Teal (brighter)
  static const Color gradientEnd = Color(0xFFD1C4E9); // Light Purple (softer)

  // Glass container
  static Color glassWhite = Colors.white.withOpacity(0.12);
  static Color glassWhiteBorder = Colors.white.withOpacity(0.2);
  static const Color glassWhiteText = Colors.black87;

  // Text colors
  static const Color textWhite = Colors.white;
  static const Color textWhite70 = Colors.white70;
  static const Color textGrey = Colors.grey;

  // Button colors
  static Color buttonText = Colors.white;
  static Color buttonGlass = Colors.teal.withOpacity(0.5);

  // Other UI colors
  static const Color shadow = Colors.black26;
}
