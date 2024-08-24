import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'joke.dart';

class JokesReader {
  late DagJokesCollection dagJokesCollection;
  List<Joke> _jokes = [];
  final Map<int, int> _dependencyCount = {};
  final Map<int, List<int>> _reverseDependencies = {};
  final Set<int> _toldJokes = {};
  final List<Joke> _readyJokes = [];
  final Random _random = Random();



  JokesReader(String filePath) {
    String jsonString = File(filePath).readAsStringSync();
    Map<String, dynamic> data = jsonDecode(jsonString);
    dagJokesCollection = DagJokesCollection.fromJson(data);
    _jokes = dagJokesCollection.jokes;
    _initializeDependencies();
  }
  
  void _initializeDependencies() {
    for (var joke in _jokes) {


      // If a joke has no dependencies, it's ready to be told
      if (joke.dependsOn.isEmpty) {
        _readyJokes.add(joke);
      }
      else
      {
          _dependencyCount[joke.id] = joke.dependsOn.length;
      }

      for (var dep in joke.dependsOn) {
        if (!_reverseDependencies.containsKey(dep)) {
          _reverseDependencies[dep] = [];
        }
        _reverseDependencies[dep]!.add(joke.id);
      }
    }
  }

Iterable<Joke> get jokes sync* {
    while (_toldJokes.length < _jokes.length) {
      var joke = _getNextJoke();
      if (joke != null) {
        // Yield the joke first (joke is told)
        yield joke;
        // Then update dependencies after the joke is told
        _updateDependencies(joke.id);
      } else {
        break;
      }
    }
  }

  Joke? _getNextJoke() {
    if (_readyJokes.isEmpty) {
      return null; // No more jokes are ready to be told
    }

    Joke selectedJoke = _readyJokes.removeAt(_random.nextInt(_readyJokes.length));
    _toldJokes.add(selectedJoke.id);
    return selectedJoke;
  }

  void _updateDependencies(int toldJokeId) {
    if (_reverseDependencies.containsKey(toldJokeId)) {
      for (var depId in _reverseDependencies[toldJokeId]!) {
        _dependencyCount[depId] = _dependencyCount[depId]! - 1;
        if (_dependencyCount[depId] == 0) {
          _readyJokes.add(_jokes.firstWhere((joke) => joke.id == depId));
          _dependencyCount.remove(depId);
        }
      }
    }
    _reverseDependencies.remove(toldJokeId);
  }
}
