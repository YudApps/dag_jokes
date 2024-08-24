import 'package:elephant_jokes/dag_jokes/joke.dart';
import 'package:flutter/material.dart';

import 'joke_panel_widget.dart';

class JokeWidget extends StatelessWidget {
  final Joke joke;
  final DagJokesCollection dagJokesCollection;
  final bool showAnswer;

  const JokeWidget({
    super.key,
    required this.joke,
    required this.dagJokesCollection,
    required this.showAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return showAnswer
        ? JokePanelWidget(
            text: joke.answer,
            icon: const Icon(
              Icons.error_outline, // Exclamation mark icon
              color: Colors.red,
              size: 24.0,
            ),
            imagePath: joke.answerImagePath ??
                dagJokesCollection.defaultAnswerImagePath,
              style: JokePanelStyles.answer,)
        : JokePanelWidget(
            text: joke.question,
            icon: const Icon(
              Icons.help_outline, // Question mark icon
              color: Colors.blue,
              textDirection: TextDirection.ltr,
              size: 24.0,
            ),
            imagePath: joke.questionImagePath ??
                dagJokesCollection.defaultQuestionImagePath,
            style: JokePanelStyles.question,);
  }
}

class JokePanelStyles {
  static JokePanelStyle question = const JokePanelStyle(
    backgroundColor: Color(0xFFA3D5FF), // Soft Pastel Blue
    textColor: Color(0xFF333333), // Dark Charcoal
  );

  static JokePanelStyle answer = const JokePanelStyle(
    backgroundColor: Color(0xFFFFF5BA), // Light Pastel Yellow
    textColor: Color(0xFF333333), // Dark Charcoal
  );
}

class JokePanelStyle {
  final Color backgroundColor;
  final Color textColor;

  const JokePanelStyle({
    required this.backgroundColor,
    required this.textColor,
  });
}
