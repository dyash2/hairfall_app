import 'package:flutter/material.dart';
import 'package:app/core/themes/app_colors.dart';

class GradientUtils {
  static const LinearGradient defaultGradient = LinearGradient(
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration defaultBoxDecoration({BorderRadius? borderRadius}) {
    return BoxDecoration(gradient: defaultGradient, borderRadius: borderRadius);
  }
}
