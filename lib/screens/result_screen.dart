import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../config/routes.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/explanation_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar menggunakan MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final quizProvider = context.watch<QuizProvider>();
    final isDark = quizProvider.isDarkMode;
    final questions = quizProvider.questions;

    return AppScaffold(
      title: 'Hasil Evaluasi Kuis',
      showBackButton: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          final maxWidth = isLargeScreen ? screenWidth * 0.65 : constraints.maxWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // KARTU RINGKASAN SKOR UTAMA DINAMIS
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: screenWidth * 0.03,
                            offset: Offset(0, screenHeight * 0.005),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // GAMBAR BADGE HASIL DARI ASSETS
                          Image.asset(
                            'assets/images/result_badge.png',
                            height: screenHeight * 0.16,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          // Nama Peserta
                          Text(
                            'Selamat, ${quizProvider.userName}!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * (isLargeScreen ? 0.038 : 0.055),
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF1E3A8A),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),

                          // Angka Skor Akhir Besar
                          Text(
                            '${quizProvider.finalScore}',
                            style: TextStyle(
                              fontSize: screenWidth * (isLargeScreen ? 0.08 : 0.14),
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2563EB),
                            ),
                          ),
                          Text(
                            'Benar ${quizProvider.correctAnswersCount} dari ${quizProvider.totalQuestions} Soal',
                            style: TextStyle(
                              fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.036),
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.blueGrey.shade700,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),

                          // Predikat Pemahaman Etika
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.035,
                              vertical: screenHeight * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(screenWidth * 0.05),
                            ),
                            child: Text(
                              quizProvider.scorePredicate,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.036),
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.lightBlueAccent : const Color(0xFF1D4ED8),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.025),

                          // DERETAN TOMBOL AKSI DINAMIS
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    context.read<QuizProvider>().resetQuiz(clearName: true);
                                    context.go(AppRoutes.welcome);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.016,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                    ),
                                  ),
                                  child: Text(
                                    'Ganti Peserta',
                                    style: TextStyle(
                                      fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.036),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<QuizProvider>().resetQuiz(clearName: false);
                                    context.go(AppRoutes.quiz);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2563EB),
                                    padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.016,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                    ),
                                  ),
                                  child: Text(
                                    'Ulangi Kuis',
                                    style: TextStyle(
                                      fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.036),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.035),

                    // JUDUL BAGIAN PEMBAHASAN ILMIAH DINAMIS
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pembahasan & Evaluasi Jawaban:',
                        style: TextStyle(
                          fontSize: screenWidth * (isLargeScreen ? 0.03 : 0.045),
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // DAFTAR KARTU PEMBAHASAN (ExplanationCard)
                    ...List.generate(questions.length, (index) {
                      return ExplanationCard(
                        questionNumber: index + 1,
                        question: questions[index],
                        userAnswerIndex: quizProvider.getSelectedAnswerFor(index),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}