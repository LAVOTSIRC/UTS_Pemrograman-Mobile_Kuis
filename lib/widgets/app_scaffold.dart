import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final bool showBackButton;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran lebar layar
    final screenWidth = MediaQuery.of(context).size.width;

    // Membaca status Dark Mode dari QuizProvider menggunakan context.watch
    final isDark = context.watch<QuizProvider>().isDarkMode;

    return Container(
      // Background Gradien
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
            const Color(0xFF0F172A), // Warna background saat Dark Mode
            const Color(0xFF1E293B),
          ]
              : [
            const Color(0xFFEFF6FF), // Warna background saat Light Mode
            const Color(0xFFDBEAFE),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Transparan agar gradien terlihat
        appBar: AppBar(
          automaticallyImplyLeading: showBackButton,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: title != null
              ? Text(
            title!,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1E3A8A),
            ),
          )
              : null,
          actions: [
            // Tombol Ganti Tema (Dark / Light Mode)
            IconButton(
              onPressed: () {
                // Memicu fungsi toggleTheme()
                context.read<QuizProvider>().toggleTheme();
              },
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: isDark ? Colors.amber : const Color(0xFF1E3A8A),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: body,
        ),
      ),
    );
  }
}