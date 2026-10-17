import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    // Mengecek jawaban apa yang sudah dipilih peserta untuk soal nomor ini (bisa null jika belum memilih)
    final selectedOption = quizProvider.getSelectedAnswerFor(currentIndex);

    return AppScaffold(
      title: 'Soal ${currentIndex + 1} dari $totalQuestions',
      showBackButton: true,
      // LayoutBuilder agar tetap rapi saat layar Landscape / Tablet
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          final maxWidth = isLargeScreen ? 550.0 : constraints.maxWidth;

          // SingleChildScrollView wajib ada agar tidak pernah overflow saat dirotasi
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SAPAAN NAMA PESERTA & KATEGORI SOAL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Peserta: ${quizProvider.userName}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.blueGrey.shade700,
                            ),
                          ),
                        ),
                        // Badge Kategori Soal (Etika AI / Metodologi)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            currentQuestion.category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.lightBlueAccent : const Color(0xFF1D4ED8),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.015),

                    // PROGRESS BAR KUIS
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: quizProvider.progress,
                        minHeight: 8,
                        backgroundColor: isDark ? Colors.white12 : Colors.blue.shade100,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    // KARTU TEKS PERTANYAAN
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        currentQuestion.questionText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    // DAFTAR 4 PILIHAN JAWABAN MENGGUNAKAN REUSABLE WIDGET OptionCard
                    ...List.generate(currentQuestion.options.length, (index) {
                      return OptionCard(
                        optionIndex: index,
                        optionText: currentQuestion.options[index],
                        isSelected: selectedOption == index,
                        onTap: () {
                          // Menyimpan pilihan jawaban ke QuizProvider
                          context.read<QuizProvider>().selectAnswer(index);
                        },
                      );
                    }),

                    SizedBox(height: screenHeight * 0.02),

                    // 5. TOMBOL NAVIGASI SOAL (SEBELUMNYA & SELANJUTNYA / SELESAI)
                    Row(
                      children: [
                        // Tombol "Sebelumnya" hanya muncul jika bukan di Soal 1
                        if (currentIndex > 0) ...[
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                context.read<QuizProvider>().previousQuestion();
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Sebelumnya',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                        ],

                        // Tombol "Selanjutnya" (atau "Lihat Skor" jika di soal terakhir)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Validasi: Pastikan peserta sudah memilih jawaban sebelum lanjut!
                              if (selectedOption == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Pilih salah satu jawaban terlebih dahulu!'),
                                  ),
                                );
                                return;
                              }

                              if (quizProvider.isLastQuestion) {
                                // TODO: Nanti di arahkan ke ResultScreen (Halaman Skor Akhir)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Kuis Selesai! Skor kamu: ${quizProvider.finalScore}',
                                    ),
                                  ),
                                );
                              } else {
                                // Pindah ke soal berikutnya
                                context.read<QuizProvider>().nextQuestion();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              quizProvider.isLastQuestion ? 'Selesai & Lihat Skor' : 'Selanjutnya',
                              style: const TextStyle(
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