// lib/data/game_state.dart
import 'words.dart';
import 'dart:math';

class GameState {
  static final GameState _instance = GameState._internal();

  factory GameState() => _instance;

  GameState._internal();

  List<List<String>> currentGrid = [];
  List<List<int>> currentStatusGrid = [];

  int currentRow = 0;
  int currentCol = 0;
  int score = 0;
  String currentWord = '';
  String targetWord = '';

  void saveGameState({
    required List<List<String>> grid,
    required List<List<int>> statusGrid,
    required int row,
    required int col,
    required int currentScore,
    required String partialWord,
    required String answerWord,
  }) {
    currentGrid = grid.map((r) => List<String>.from(r)).toList();
    currentStatusGrid =
        statusGrid.map((r) => List<int>.from(r)).toList(); // guardar estados
    currentRow = row;
    currentCol = col;
    score = currentScore;
    currentWord = partialWord;
    targetWord = answerWord;
  }

  void reset() {
    currentGrid = [];
    currentStatusGrid = [];
    currentRow = 0;
    currentCol = 0;
    score = 0;
    currentWord = '';
    targetWord = '';
  }

  void continueReset() {
    currentGrid = [];
    currentStatusGrid = [];
    currentRow = 0;
    currentCol = 0;
    score++;
    currentWord = '';
    targetWord =
        fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase();
  }

  bool hasSavedGame() {
    return (currentGrid.isNotEmpty && targetWord.isNotEmpty) || score > 0;
  }
}
