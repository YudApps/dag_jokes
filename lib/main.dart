import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dag_jokes/dag_jokes_reader.dart';
import 'dag_jokes/joke.dart';
import 'joke_widget.dart';

void main() {
  runApp(const DagJokesApp());
}

class DagJokesApp extends StatelessWidget {
  const DagJokesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DAG Jokes",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: const ColorScheme(
          primary: Color(0xFFA9A9A9), // Elephant Gray
          secondary: Color(0xFFFFD700), // Sunny Yellow
          surface: Color(0xFFFFFFFF), // White surface
          error: Color(0xFFB00020), // Default error color
          onPrimary: Color(0xFF000000), // Black text on primary
          onSecondary: Color(0xFF000000), // Black text on secondary
          onSurface: Color(0xFF000000), // Black text on surface
          onError: Color(0xFFFFFFFF), // White text on error
          brightness: Brightness.light, // Light theme
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('he'),
      home: const DagJokesHomePage(title: 'DAG Jokes'),
    );
  }
}

class DagJokesHomePage extends StatefulWidget {
  const DagJokesHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<DagJokesHomePage> createState() => _DagJokesHomePageState();
}

class _DagJokesHomePageState extends State<DagJokesHomePage> {
  late JokesReader _jokesReader;
  late Iterator<Joke> _jokesIterator;
  Joke? _currentJoke;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _jokesReader = JokesReader('assets/dag_jokes_files/elephant_jokes.he.json');
    _jokesIterator = _jokesReader.jokes.iterator;
    _loadNextJoke();
  }

  void _loadNextJoke() {
    if (_jokesIterator.moveNext()) {
      _currentJoke = _jokesIterator.current;
    } else {
      _currentJoke = null; // No more jokes available
    }
  }

  void _handleTap() {
    setState(() {
      if (_showAnswer) {
        // Move to the next joke if the answer is currently being shown
        _showAnswer = false;
        _loadNextJoke();
      } else {
        // Show the answer if currently showing the question
        _showAnswer = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dagJokes),
      ),
      body: GestureDetector(
        onTap: _handleTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _currentJoke != null
                ? JokeWidget(
                    joke: _currentJoke!,
                    dagJokesCollection: _jokesReader.dagJokesCollection,
                    showAnswer: _showAnswer)
                : const Text(
                    'No more jokes!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0),
                  ),
          ),
        ),
      ),
    );
  }
}
