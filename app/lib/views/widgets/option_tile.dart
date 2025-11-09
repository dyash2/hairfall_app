import 'package:app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? Colors.white.withOpacity(0.30)
              : Colors.white.withOpacity(0.12),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.8)
                : AppColors.glassWhiteBorder,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: (_) => onTap(),
              fillColor: MaterialStateProperty.all(Colors.white),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
