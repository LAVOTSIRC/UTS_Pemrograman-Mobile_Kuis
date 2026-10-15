import '../models/question_model.dart';

// Pilihan GANDA
// Option => Index 0 = A, Index 1 = B, Index 2 = C, Index 3 = D

class QuizData {
  static const List<Question> questions = [
    Question(
      id: 'q1',
      category: 'Etika & AI dalam Skripsi',
      questionText:
      'Saat menyusun Bab 2 (Tinjauan Pustaka), Budi meminta AI untuk mencarikan teori beserta daftar pustakanya, lalu langsung menyalinnya ke skripsi tanpa mengecek jurnal aslinya. Ternyata jurnal tersebut fiktif (AI Hallucination). Pelanggaran apa yang terjadi?',
      options: [
        'Hanya kesalahan teknis biasa karena salah AI-nya',
        'Fabrikasi kutipan/referensi dan kelalaian verifikasi ilmiah',
        'Self-plagiarism karena menggunakan prompt milik sendiri',
        'Salami slicing dalam publikasi ilmiah',
      ],
      correctAnswerIndex: 1, // Jawaban B
      explanation:
      'AI Generatif sering mengalami halusinasi (mengarang referensi yang terlihat meyakinkan padahal tidak ada). Peneliti bertanggung jawab penuh memverifikasi setiap sumber primer yang dikutip.',
    ),
    Question(
      id: 'q2',
      category: 'Etika Karya Ilmiah',
      questionText:
      'Siti menggunakan ulang 3 paragraf penuh dari makalahnya sendiri yang sudah pernah dipublikasikan tahun lalu ke dalam naskah skripsinya tanpa mencantumkan sitasi ke makalah lamanya. Tindakan ini disebut...',
      options: [
        'Bukan pelanggaran karena itu karyanya sendiri',
        'Hak prerogatif penulis (Author Privilege)',
        'Self-plagiarism (Auto-plagiarisme)',
        'Parafrase tingkat lanjut',
      ],
      correctAnswerIndex: 2, // Jawaban C
      explanation:
      'Menggunakan kembali karya sendiri yang sudah dipublikasikan tanpa sitasi yang jelas disebut Self-plagiarism (Auto-plagiarisme), karena mengklaim karya lama sebagai kebaruan (novelty) baru.',
    ),
    Question(
      id: 'q3',
      category: 'Etika Penelitian',
      questionText:
      'Saat menguji model Machine Learning untuk skripsinya, akurasi model Andi hanya 62%. Karena takut sidang ditunda, Andi mengubah angka di tabel hasil pengujian menjadi 91% tanpa melatih ulang model. Pelanggaran berat ini disebut...',
      options: [
        'Falsifikasi Data (Data Falsification)',
        'Normalisasi Data (Data Normalization)',
        'Augmentasi Data (Data Augmentation)',
        'Optimasi Hiperparameter',
      ],
      correctAnswerIndex: 0, // Jawaban A
      explanation:
      'Mengubah atau memanipulasi data/hasil penelitian agar sesuai dengan harapan peneliti adalah Falsifikasi. Bersama Fabrikasi (mengarang data dari nol) dan Plagiarisme, ini adalah 3 dosa besar akademik (FFP).',
    ),
    Question(
      id: 'q4',
      category: 'Etika & AI dalam Skripsi',
      questionText:
      'Manakah di bawah ini cara pemanfaatan Generative AI (seperti Gemini/ChatGPT) yang PALING ETIS dan diperbolehkan dalam penulisan skripsi?',
      options: [
        'Meminta AI menuliskan seluruh Bab 4 (Hasil & Pembahasan) secara otomatis',
        'Menggunakan AI untuk membuat data responden kuesioner palsu',
        'Menggunakan AI untuk memeriksa tata bahasa (proofreading), brainstorming kerangka, atau debugging kode dengan analisis tetap ditulis mandiri',
        'Menyalin teks jurnal berbahasa Inggris lalu menyuruh AI menerjemahkannya dan mengakuinya sebagai ide sendiri tanpa sitasi',
      ],
      correctAnswerIndex: 2, // Jawaban C
      explanation:
      'AI boleh digunakan sebagai asisten pendamping (proofreading, brainstorming, debugging), namun gagasan kritis, pengambilan data, dan penulisan analisis ilmiah wajib dilakukan oleh mahasiswa sendiri.',
    ),
    Question(
      id: 'q5',
      category: 'Etika Karya Ilmiah',
      questionText:
      'Rina menyalin kalimat dari jurnal orang lain, lalu hanya mengganti beberapa kata dengan sinonimnya menggunakan tools paraphraser tanpa mengubah struktur kalimat dan tanpa mencantumkan sitasi. Praktik ini termasuk...',
      options: [
        'Teknik sitasi tidak langsung yang sah',
        'Mosaic Plagiarism (Patchwriting)',
        'Systematic Literature Review',
        'Sintesis teori ilmiah',
      ],
      correctAnswerIndex: 1, // Jawaban B
      explanation:
      'Mengganti kata dengan sinonim tanpa mengubah struktur gagasan dan tanpa menyebutkan sumber aslinya disebut Mosaic Plagiarism (Patchwriting) dan tetap merupakan pelanggaran integritas akademik.',
    ),
    Question(
      id: 'q6',
      category: 'Metodologi Penelitian',
      questionText:
      'Dalam menyusun Latar Belakang skripsi (Bab 1), komponen krusial yang menunjukkan celah masalah yang belum diselesaikan oleh penelitian-penelitian terdahulu disebut...',
      options: [
        'Hipotesis Nol (H0)',
        'Manfaat Praktis Penelitian',
        'Research Gap (Kesenjangan Penelitian)',
        'Populasi dan Sampel',
      ],
      correctAnswerIndex: 2, // Jawaban C
      explanation:
      'Research Gap adalah celah atau keterbatasan dari penelitian terdahulu yang menjadi alasan kuat mengapa penelitian/skripsi kamu penting dan memiliki kebaruan (novelty) untuk dikerjakan.',
    ),
    Question(
      id: 'q7',
      category: 'Metodologi Penelitian',
      questionText:
      'Jika judul skripsimu adalah "Pengaruh Penggunaan Arsitektur Transformer terhadap Akurasi Deteksi Berita Hoaks", maka yang menjadi Variabel Dependen (Terikat) adalah...',
      options: [
        'Arsitektur Transformer',
        'Akurasi Deteksi Berita Hoaks',
        'Jumlah Berita Hoaks di Media Sosial',
        'Spesifikasi Laptop Peneliti',
      ],
      correctAnswerIndex: 1, // Jawaban B
      explanation:
      'Variabel Independen (Bebas) adalah yang memengaruhi (Arsitektur Transformer), sedangkan Variabel Dependen (Terikat) adalah hasil yang dipengaruhi/diukur (Akurasi Deteksi Berita Hoaks).',
    ),
    Question(
      id: 'q8',
      category: 'Etika & Metodologi',
      questionText:
      'Sebelum menyebarkan kuesioner atau mewawancarai responden untuk data skripsi, peneliti wajib meminta persetujuan responden secara sadar tanpa paksaan serta menjaga kerahasiaan identitas mereka. Prinsip ini disebut...',
      options: [
        'Informed Consent dan Konfidensialitas',
        'Peer Review dan Open Access',
        'Snowball Sampling',
        'Uji Normalitas Kolmogorov-Smirnov',
      ],
      correctAnswerIndex: 0, // Jawaban A
      explanation:
      'Informed Consent memastikan subjek penelitian tahu tujuan riset dan setuju berpartisipasi secara sukarela, sedangkan konfidensialitas melindungi privasi data pribadi responden.',
    ),
    Question(
      id: 'q9',
      category: 'Metodologi Penelitian',
      questionText:
      'Kamu ingin meneliti kepuasan pengguna Portal Akademik Kampus, sehingga kamu menetapkan syarat bahwa responden HARUS mahasiswa aktif yang sudah memakai portal minimal 2 semester. Teknik pemilihan sampel dengan kriteria khusus ini disebut...',
      options: [
        'Simple Random Sampling',
        'Purposive Sampling',
        'Accidental / Convenience Sampling',
        'Cluster Random Sampling',
      ],
      correctAnswerIndex: 1, // Jawaban B
      explanation:
      'Purposive Sampling adalah teknik penentuan sampel dengan pertimbangan atau kriteria tertentu agar data yang diperoleh benar-benar representatif terhadap tujuan penelitian.',
    ),
    Question(
      id: 'q10',
      category: 'Metodologi Penelitian',
      questionText:
      'Dalam pengujian instrumen penelitian (seperti kuesioner), ukuran yang menunjukkan sejauh mana alat ukur tersebut memberikan hasil yang KONSISTEN dan STABIL jika diujikan berulang kali disebut...',
      options: [
        'Uji Validitas',
        'Uji Reliabilitas',
        'Uji Regresi Linear Berganda',
        'Uji Multikolinearitas',
      ],
      correctAnswerIndex: 1, // Jawaban B
      explanation:
      'Validitas mengukur "ketepatan" alat ukur (apakah mengukur apa yang seharusnya diukur), sedangkan Reliabilitas mengukur "kekonsistenan/kestabilan" hasil pengukuran tersebut.',
    ),
  ];
}