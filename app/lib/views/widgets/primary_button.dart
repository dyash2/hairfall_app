import 'package:app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // side:  BorderSide(color: isDisabled ? Colors.grey.shade400 : Colors.teal.withOpacity(0.4))
          ),
          backgroundColor: AppColors.buttonGlass,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            letterSpacing: 1.2,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
  }
}
