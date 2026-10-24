import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../config/routes.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_scaffold.dart';

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

    final quizProvider = context.read<QuizProvider>();
    quizProvider.resetQuiz();
    quizProvider.setUserName(name);

    context.push(AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar secara dinamis menggunakan MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = context.watch<QuizProvider>().isDarkMode;

    return AppScaffold(
      title: 'Scholaria Quiz',
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          final maxWidth = isLargeScreen ? screenWidth * 0.6 : constraints.maxWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.02),

                    // GAMBAR LOGO DARI ASSETS
                    Image.asset(
                      'assets/images/ethics_logo.png',
                      height: screenHeight * 0.22,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // JUDUL APLIKASI DINAMIS
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

                    // KOTAK FORM INPUT NAMA DINAMIS
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: screenWidth * 0.025,
                            offset: Offset(0, screenHeight * 0.005),
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
                            style: TextStyle(
                              fontSize: screenWidth * (isLargeScreen ? 0.025 : 0.038),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Masukkan nama lengkapmu...',
                              hintStyle: TextStyle(
                                fontSize: screenWidth * (isLargeScreen ? 0.024 : 0.036),
                              ),
                              errorText: _errorText,
                              prefixIcon: Icon(
                                Icons.person,
                                size: screenWidth * (isLargeScreen ? 0.035 : 0.055),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenWidth * 0.04,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.025),

                          // TOMBOL MULAI KUIS DINAMIS
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.065,
                            child: ElevatedButton(
                              onPressed: _startQuiz,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
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