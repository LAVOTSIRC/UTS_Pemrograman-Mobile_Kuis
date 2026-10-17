import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_scaffold.dart';

// Menggunakan StatefulWidget karena butuh initState & dispose untuk TextEditingController
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late TextEditingController _nameController;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    // Ambil nama dari QuizProvider supaya kalau layar dirotasi tidak hilang
    final savedName = context.read<QuizProvider>().userName;
    _nameController = TextEditingController(text: savedName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorText = 'Nama tidak boleh kosong!';
      });
      return;
    }

    // Simpan nama ke QuizProvider
    final quizProvider = context.read<QuizProvider>();
    quizProvider.resetQuiz();
    quizProvider.setUserName(name);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selamat datang, $name!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = context.watch<QuizProvider>().isDarkMode;

    return AppScaffold(
      title: 'Scholaria Quiz',
      // LayoutBuilder untuk membatasi lebar di layar besar/Landscape
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          final maxWidth = isLargeScreen ? 500.0 : constraints.maxWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.02),

                    // 1. GAMBAR LOGO DARI ASSETS
                    Image.asset(
                      'assets/images/ethics_logo.png',
                      height: screenHeight * 0.22, // Tinggi gambar 22% dari tinggi layar
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // 2. JUDUL APLIKASI
                    Text(
                      'Etika Karya Ilmiah & Metodologi di Era AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * (isLargeScreen ? 0.04 : 0.06),
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF1E3A8A),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.015),

                    Text(
                      'Uji pemahamanmu seputar etika penggunaan AI dalam skripsi dan metodologi penelitian ilmiah.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * (isLargeScreen ? 0.025 : 0.038),
                        color: isDark ? Colors.white70 : Colors.blueGrey.shade700,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // 3. KOTAK FORM INPUT NAMA
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Peserta:',
                            style: TextStyle(
                              fontSize: screenWidth * (isLargeScreen ? 0.028 : 0.04),
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),

                          // TextField Input Nama
                          TextField(
                            controller: _nameController,
                            onChanged: (value) {
                              context.read<QuizProvider>().setUserName(value);
                              if (_errorText != null) {
                                setState(() {
                                  _errorText = null;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukkan nama lengkapmu...',
                              errorText: _errorText,
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.025),

                          // 4. TOMBOL MULAI KUIS
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _startQuiz,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Mulai Kuis',
                                style: TextStyle(
                                  fontSize: screenWidth * (isLargeScreen ? 0.03 : 0.045),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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