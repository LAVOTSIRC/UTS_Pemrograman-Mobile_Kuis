import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;

  // Menyimpan jawaban peserta dalam bentuk Map: { indeksSoal : indeksPilihanJawaban }
  // Contoh: { 0: 1, 1: 2 } artinya Soal no 1 jawab B (1), Soal no 2 jawab C (2)
  final Map<int, int> _selectedAnswers = {};

  // 2. GETTER PUBLIK (Untuk dibaca oleh UI)
  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  Map<int, int> get selectedAnswers => _selectedAnswers;

  // Mengambil seluruh daftar soal dari QuizData
  List<Question> get questions => QuizData.questions;
  int get totalQuestions => questions.length;

  // Mengambil objek soal yang sedang aktif saat ini
  Question get currentQuestion => questions[_currentQuestionIndex];

  // Mengecek apakah soal saat ini adalah soal terakhir
  bool get isLastQuestion => _currentQuestionIndex == totalQuestions - 1;

  // Menghitung persentase progres (0.1 sampai 1.0) untuk Progress Bar di atas layar
  double get progress => (_currentQuestionIndex + 1) / totalQuestions;

  // Mengecek berapa banyak soal yang sudah dijawab
  int get answeredCount => _selectedAnswers.length;

  // 3. METHOD LOGIKA KUIS (Untuk dipanggil oleh interaksi tombol pengguna)

  // Menyimpan nama user saat mulai kuis
  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  // Menyimpan pilihan jawaban user pada soal yang sedang aktif
  void selectAnswer(int optionIndex) {
    _selectedAnswers[_currentQuestionIndex] = optionIndex;
    notifyListeners();
  }

  // Mengecek jawaban apa yang dipilih user pada indeks soal tertentu (bisa null jika belum dijawab)
  int? getSelectedAnswerFor(int questionIndex) {
    return _selectedAnswers[questionIndex];
  }

  // Pindah ke soal berikutnya
  void nextQuestion() {
    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Kembali ke soal sebelumnya (Fitur tambahan agar user bisa meninjau jawaban!)
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Lompat langsung ke nomor soal tertentu (pakai indikator nomor soal)
  void goToQuestion(int index) {
    if (index >= 0 && index < totalQuestions) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  // Menghitung total jawaban yang benar
  int get correctAnswersCount {
    int correct = 0;
    for (int i = 0; i < totalQuestions; i++) {
      if (_selectedAnswers[i] == questions[i].correctAnswerIndex) {
        correct++;
      }
    }
    return correct;
  }

  // Menghitung skor akhir dalam skala 0 - 100
  int get finalScore {
    if (totalQuestions == 0) return 0;
    return ((correctAnswersCount / totalQuestions) * 100).round();
  }

  // Memberikan predikat kelulusan pemahaman etika ilmiah berdasarkan skor
  String get scorePredicate {
    final score = finalScore;
    if (score >= 85) {
      return 'Peneliti Berintegritas Tinggi 🌟';
    } else if (score >= 70) {
      return 'Paham Etika Ilmiah 👍';
    } else if (score >= 50) {
      return 'Cukup, Perlu Evaluasi Etika 📖';
    } else {
      return 'Rawan Pelanggaran Etika! ⚠️';
    }
  }

  // Mengulang kuis dari awal (tanpa menghapus nama, atau reset penuh)
  void resetQuiz({bool clearName = false}) {
    _currentQuestionIndex = 0;
    _selectedAnswers.clear();
    if (clearName) {
      _userName = '';
    }
    notifyListeners();
  }
}