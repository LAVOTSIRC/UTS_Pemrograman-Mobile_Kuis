import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Membungkus aplikasi dengan ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      // 2. Menggunakan Consumer agar saat tombol Dark Mode ditekan, tema MaterialApp berubah
      child: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          return MaterialApp(
            title: 'Scholaria Quiz',
            debugShowCheckedModeBanner: false,

            // Jika isDarkMode bernilai true, gunakan tema gelap. Jika false, gunakan tema terang.
            themeMode: quizProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

            // Tema Terang (Light Mode) + Font Urbanist
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'Urbanist',
              primarySwatch: Colors.blue,
            ),

            // Tema Gelap (Dark Mode) + Font Urbanist
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Urbanist',
              primarySwatch: Colors.blue,
            ),

            // Halaman pertama yang dibuka
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}