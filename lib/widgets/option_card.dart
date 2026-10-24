import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class OptionCard extends StatelessWidget {
  final int optionIndex;
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.optionIndex,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 600;
    final isDark = context.watch<QuizProvider>().isDarkMode;

    final List<String> optionLetters = ['A', 'B', 'C', 'D'];
    final String letter = optionLetters[optionIndex];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.018,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2563EB)
              : (isDark ? const Color(0xFF1E293B) : Colors.white),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF60A5FA)
                : (isDark ? Colors.white24 : Colors.grey.shade300),
            width: isSelected ? screenWidth * 0.005 : screenWidth * 0.0025,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ukuran lingkaran dinamis berdasarkan lebar layar
            Container(
              width: screenWidth * (isLargeScreen ? 0.055 : 0.09),
              height: screenWidth * (isLargeScreen ? 0.055 : 0.09),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.white12 : const Color(0xFFDBEAFE)),
              ),
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.038),
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? const Color(0xFF1E3A8A)
                      : (isDark ? Colors.white : const Color(0xFF1E3A8A)),
                ),
              ),
            ),

            SizedBox(width: screenWidth * 0.035),

            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.038),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white : Colors.black87),
                ),
              ),
            ),

            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: screenWidth * (isLargeScreen ? 0.035 : 0.055),
              ),
          ],
        ),
      ),
    );
  }
}