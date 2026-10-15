class Question {
  final String id;
  final String category;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const Question({
    required this.id,
    required this.category,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}