import 'package:go_router/go_router.dart';
import '../screens/welcome_screen.dart';
import '../screens/quiz_screen.dart';

// Kelas penyimpan konstanta alamat rute
class AppRoutes {
  static const String welcome = '/';
  static const String quiz = '/quiz';
  static const String result = '/result'; // nantinya bisa ditambahkan halaman hasil quiz
}

// Fungsi pembuat konfigurasi GoRouter
GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.welcome, // Halaman pertama (welcome)
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        name: 'quiz',
        builder: (context, state) => const QuizScreen(),
      ),
    ],
  );
}