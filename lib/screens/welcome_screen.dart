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
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width.clamp(0.0, 600.0);
    final screenHeight = size.height.clamp(0.0, 1000.0);
    final isDark = context.watch<QuizProvider>().isDarkMode;

    return AppScaffold(
      title: 'Scholaria Quiz',
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double maxWidth = screenWidth;
          final double baseWidth = screenWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth, // Gunakan maxWidth yang sudah dibatasi
                padding: EdgeInsets.all(baseWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    Image.asset(
                      'assets/images/ethics_logo.png',
                      height: screenHeight * 0.22,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      'Etika Karya Ilmiah & Metodologi di Era AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: baseWidth * 0.06,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF1E3A8A),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Uji pemahamanmu seputar etika penggunaan AI dalam skripsi dan metodologi penelitian ilmiah.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: baseWidth * 0.038,
                        color: isDark ? Colors.white70 : Colors.blueGrey.shade700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Container(
                      padding: EdgeInsets.all(baseWidth * 0.05),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(baseWidth * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: baseWidth * 0.025,
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
                              fontSize: baseWidth * 0.04,
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
                            style: TextStyle(fontSize: baseWidth * 0.038),
                            decoration: InputDecoration(
                              hintText: 'Masukkan nama lengkap...',
                              hintStyle: TextStyle(fontSize: baseWidth * 0.036),
                              errorText: _errorText,
                              prefixIcon: Icon(Icons.person, size: baseWidth * 0.055),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: baseWidth * 0.04,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(baseWidth * 0.03),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          SizedBox(
                            width: double.infinity,
                            height: (screenHeight * 0.065).clamp(45.0, 60.0), // Beri batas tinggi juga
                            child: ElevatedButton(
                              onPressed: _startQuiz,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(baseWidth * 0.03),
                                ),
                              ),
                              child: Text(
                                'Mulai Kuis',
                                style: TextStyle(
                                  fontSize: baseWidth * 0.045, // Gunakan baseWidth
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