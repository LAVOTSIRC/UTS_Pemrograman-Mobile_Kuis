import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question_model.dart';
import '../providers/quiz_provider.dart';

class ExplanationCard extends StatelessWidget {
  final int questionNumber;
  final Question question;
  final int? userAnswerIndex;

  const ExplanationCard({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.userAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 600;
    final isDark = context.watch<QuizProvider>().isDarkMode;

    final bool isCorrect = userAnswerIndex == question.correctAnswerIndex;
    final String userAnswerText = userAnswerIndex != null
        ? question.options[userAnswerIndex!]
        : 'Tidak dijawab';
    final String correctAnswerText =
    question.options[question.correctAnswerIndex];

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.045),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.redAccent,
          width: screenWidth * 0.004,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Soal #$questionNumber • ${question.category}',
                  style: TextStyle(
                    fontSize: screenWidth * (isLargeScreen ? 0.022 : 0.034),
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.lightBlueAccent : const Color(0xFF1D4ED8),
                  ),
                ),
              ),
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.redAccent,
                size: screenWidth * (isLargeScreen ? 0.035 : 0.055),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.01),

          Text(
            question.questionText,
            style: TextStyle(
              fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.037),
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          Text(
            'Jawabanmu: $userAnswerText',
            style: TextStyle(
              fontSize: screenWidth * (isLargeScreen ? 0.022 : 0.034),
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.green : Colors.redAccent,
            ),
          ),

          if (!isCorrect) ...[
            SizedBox(height: screenHeight * 0.005),
            Text(
              'Kunci Jawaban: $correctAnswerText',
              style: TextStyle(
                fontSize: screenWidth * (isLargeScreen ? 0.022 : 0.034),
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],

          SizedBox(height: screenHeight * 0.015),

          Container(
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber,
                  size: screenWidth * (isLargeScreen ? 0.032 : 0.05),
                ),
                SizedBox(width: screenWidth * 0.025),
                Expanded(
                  child: Text(
                    question.explanation,
                    style: TextStyle(
                      fontSize: screenWidth * (isLargeScreen ? 0.022 : 0.034),
                      height: 1.4,
                      color: isDark ? Colors.white70 : Colors.blueGrey.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}