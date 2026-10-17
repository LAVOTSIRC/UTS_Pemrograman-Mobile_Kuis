import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class OptionCard extends StatelessWidget {
  final int optionIndex; // 0 = A, 1 = B, 2 = C, 3 = D
  final String optionText; // Teks pilihan jawaban
  final bool isSelected; // Apakah pilihan ini sedang dipilih oleh peserta?
  final VoidCallback onTap; // Aksi saat kartu diklik

  const OptionCard({
    super.key,
    required this.optionIndex,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Mengecek apakah sedang Dark Mode dari QuizProvider
    final isDark = context.watch<QuizProvider>().isDarkMode;

    // Mengubah angka indeks (0, 1, 2, 3) menjadi huruf label ('A', 'B', 'C', 'D')
    final List<String> optionLetters = ['A', 'B', 'C', 'D'];
    final String letter = optionLetters[optionIndex];

    // Membungkus dengan GestureDetector agar kartu bisa diklik
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.018,
        ),
        decoration: BoxDecoration(
          // Jika dipilih (isSelected == true), warnanya biru menyala.
          // Jika belum dipilih, warnanya putih (Light Mode) atau abu gelap (Dark Mode).
          color: isSelected
              ? const Color(0xFF2563EB)
              : (isDark ? const Color(0xFF1E293B) : Colors.white),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF60A5FA)
                : (isDark ? Colors.white24 : Colors.grey.shade300),
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Lingkaran Huruf A / B / C / D di sebelah kiri
            Container(
              width: 36,
              height: 36,
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
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? const Color(0xFF1E3A8A)
                      : (isDark ? Colors.white : const Color(0xFF1E3A8A)),
                ),
              ),
            ),

            SizedBox(width: screenWidth * 0.035),

            // 2. Teks Pilihan Jawaban (Dibungkus Expanded agar teks panjang otomatis turun ke baris baru dan tidak overflow)
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white : Colors.black87),
                ),
              ),
            ),

            // 3. Ikon Centang jika sedang dipilih
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}