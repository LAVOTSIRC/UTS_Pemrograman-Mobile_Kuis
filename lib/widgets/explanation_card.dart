import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question_model.dart';
import '../providers/quiz_provider.dart';

class ExplanationCard extends StatelessWidget {
  final int questionNumber; // Nomor urut soal (1 sampai 10)
  final Question question; // Objek data soal
  final int? userAnswerIndex; // Jawaban yang dipilih peserta

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
    final isDark = context.watch<QuizProvider>().isDarkMode;

    // Mengecek apakah jawaban peserta benar
    final bool isCorrect = userAnswerIndex == question.correctAnswerIndex;

    // Mengambil teks jawaban peserta dan teks kunci jawaban
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
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          // Garis tepi hijau jika benar, merah jika salah
          color: isCorrect ? Colors.green : Colors.redAccent,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER KARTU: Nomor Soal & Status Benar/Salah
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Soal #$questionNumber • ${question.category}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.lightBlueAccent : const Color(0xFF1D4ED8),
                ),
              ),
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.redAccent,
                size: 22,
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.01),

          // TEKS PERTANYAAN
          Text(
            question.questionText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          // JAWABAN PESERTA
          Text(
            'Jawabanmu: $userAnswerText',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.green : Colors.redAccent,
            ),
          ),

          // Jika salah, tampilkan Kunci Jawaban yang benar
          if (!isCorrect) ...[
            SizedBox(height: screenHeight * 0.005),
            Text(
              'Kunci Jawaban: $correctAnswerText',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],

          SizedBox(height: screenHeight * 0.015),

          // KOTAK PEMBAHASAN ILMIAH
          Container(
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber,
                  size: 20,
                ),
                SizedBox(width: screenWidth * 0.025),
                Expanded(
                  child: Text(
                    question.explanation,
                    style: TextStyle(
                      fontSize: 13,
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