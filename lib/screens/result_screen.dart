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
    // Mengambil ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Membaca data hasil kuis dari QuizProvider
    final quizProvider = context.watch<QuizProvider>();
    final isDark = quizProvider.isDarkMode;
    final questions = quizProvider.questions;

    return AppScaffold(
      title: 'Hasil Evaluasi Kuis',
      showBackButton: false, // Tidak perlu tombol back agar peserta tidak kembali ke soal terakhir begitu saja
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          final maxWidth = isLargeScreen ? 550.0 : constraints.maxWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // KARTU RINGKASAN SKOR UTAMA
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
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
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.blueGrey.shade700,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),

                          // Predikat Pemahaman Etika
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              quizProvider.scorePredicate,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.lightBlueAccent : const Color(0xFF1D4ED8),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.025),

                          // 2. DERETAN TOMBOL AKSI (ULANGI KUIS & GANTI PESERTA)
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    // Reset kuis beserta nama, lalu kembali ke halaman WelcomeScreen
                                    context.read<QuizProvider>().resetQuiz(clearName: true);
                                    context.go(AppRoutes.welcome);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Ganti Peserta',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Reset jawaban saja (nama tetap), lalu kembali ke Soal 1
                                    context.read<QuizProvider>().resetQuiz(clearName: false);
                                    context.go(AppRoutes.quiz);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2563EB),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Ulangi Kuis',
                                    style: TextStyle(
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

                    // JUDUL BAGIAN PEMBAHASAN ILMIAH
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pembahasan & Evaluasi Jawaban:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // DAFTAR KARTU PEMBAHASAN (Menggunakan Reusable Widget ExplanationCard)
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