import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import 'providers/quiz_provider.dart';

void main() {
  runApp(const MyApp());
}

// simpan instance router di luar build agar rute tidak ter-reset saat ganti tema (Dark/Light Mode)!
final _router = createRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          // Menggunakan MaterialApp.router
          return MaterialApp.router(
            title: 'Scholaria Quiz',
            debugShowCheckedModeBanner: false,
            themeMode: quizProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'Urbanist',
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Urbanist',
              primarySwatch: Colors.blue,
            ),
            // Menghubungkan konfigurasi GoRouter ke MaterialApp
            routerConfig: _router,
          );
        },
      ),
    );
  }
}