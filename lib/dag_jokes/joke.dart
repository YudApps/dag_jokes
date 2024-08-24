class Joke {
  int id;
  String question;
  String? questionImagePath;
  String answer;
  String? answerImagePath;
  List<int> dependsOn;

  Joke({required this.id, required this.question, this.questionImagePath, required this.answer, this.answerImagePath, required this.dependsOn});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'],
      question: json['question'],
      questionImagePath: json['question_image_path'] as String?,
      answer: json['answer'],
      answerImagePath: json['answer_image_path'] as String?,
      dependsOn: List<int>.from(json['depends_on']),
    );
  }
}

class DagJokesCollection {
  String defaultQuestionImagePath;
  String defaultAnswerImagePath;
  List<Joke> jokes;

  DagJokesCollection({required this.defaultQuestionImagePath, required this.defaultAnswerImagePath, required this.jokes});

  factory DagJokesCollection.fromJson(Map<String, dynamic> json) {
    return DagJokesCollection(
      defaultQuestionImagePath: json['default_question_image_path'],
      defaultAnswerImagePath: json['default_answer_image_path'],
      jokes: (json['jokes'] as List)
        .map((jokeData) => Joke.fromJson(jokeData))
        .toList(),
    );
  }
}
