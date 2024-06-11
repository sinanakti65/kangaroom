import 'dart:convert';

// JSON'daki verileri işlemek için model sınıfı
class Question {
  final String question;
  final Map<String, String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['soru'],
      options: Map<String, String>.from(json['secenekler']),
      correctAnswer: json['dogruCevap'],
    );
  }
}

// JSON dosyasındaki tüm soruları işlemek için bir sınıf
class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});

  factory Quiz.fromJson(String jsonString) {
    final parsed = jsonDecode(jsonString);
    var questionList = parsed['sorular'] as List<dynamic>;
    List<Question> questions =
    questionList.map((json) => Question.fromJson(json)).toList();
    return Quiz(questions: questions);
  }
}
