import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../config/routes.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/option_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar menggunakan MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Mendengarkan data kuis dari QuizProvider
    final quizProvider = context.watch<QuizProvider>();
    final currentQuestion = quizProvider.currentQuestion;
    final currentIndex = quizProvider.currentQuestionIndex;
    final totalQuestions = quizProvider.totalQuestions;
    final isDark = quizProvider.isDarkMode;

    final selectedOption = quizProvider.getSelectedAnswerFor(currentIndex);

    return AppScaffold(
      title: 'Soal ${currentIndex + 1} dari $totalQuestions',
      showBackButton: true,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SAPAAN NAMA PESERTA & KATEGORI SOAL DINAMIS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Peserta: ${quizProvider.userName}',
                            style: TextStyle(
                              fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.036),
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.blueGrey.shade700,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(screenWidth * 0.05),
                          ),
                          child: Text(
                            currentQuestion.category,
                            style: TextStyle(
                              fontSize: screenWidth * (isLargeScreen ? 0.02 : 0.032),
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.lightBlueAccent : const Color(0xFF1D4ED8),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.015),

                    // PROGRESS BAR KUIS DINAMIS
                    ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      child: LinearProgressIndicator(
                        value: quizProvider.progress,
                        minHeight: screenHeight * 0.01,
                        backgroundColor: isDark ? Colors.white12 : Colors.blue.shade100,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    // KARTU TEKS PERTANYAAN DINAMIS
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: screenWidth * 0.025,
                            offset: Offset(0, screenHeight * 0.005),
                          ),
                        ],
                      ),
                      child: Text(
                        currentQuestion.questionText,
                        style: TextStyle(
                          fontSize: screenWidth * (isLargeScreen ? 0.026 : 0.042),
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    // DAFTAR 4 PILIHAN JAWABAN (OptionCard)
                    ...List.generate(currentQuestion.options.length, (index) {
                      return OptionCard(
                        optionIndex: index,
                        optionText: currentQuestion.options[index],
                        isSelected: selectedOption == index,
                        onTap: () {
                          context.read<QuizProvider>().selectAnswer(index);
                        },
                      );
                    }),

                    SizedBox(height: screenHeight * 0.02),

                    // TOMBOL NAVIGASI SOAL DINAMIS
                    Row(
                      children: [
                        if (currentIndex > 0) ...[
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                context.read<QuizProvider>().previousQuestion();
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.018,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                ),
                              ),
                              child: Text(
                                'Sebelumnya',
                                style: TextStyle(
                                  fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.038),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                        ],

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (selectedOption == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Pilih salah satu jawaban terlebih dahulu!'),
                                  ),
                                );
                                return;
                              }

                              if (quizProvider.isLastQuestion) {
                                context.go(AppRoutes.result);
                              } else {
                                context.read<QuizProvider>().nextQuestion();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.018,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                              ),
                            ),
                            child: Text(
                              quizProvider.isLastQuestion ? 'Selesai & Lihat Skor' : 'Selanjutnya',
                              style: TextStyle(
                                fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.038),
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
            ),
          );
        },
      ),
    );
  }
}