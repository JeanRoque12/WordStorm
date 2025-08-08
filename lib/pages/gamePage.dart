import 'dart:math';
import 'package:flutter/material.dart';
import '../data/themes.dart';
import '../components/board.dart';
import '../components/keyboard.dart';
import '../data/words.dart';
import '../components/win_dialog.dart';
import '../components/lose_dialog.dart';
import '../components/options_dialog.dart';
import '../data/game_state.dart';

class WordStormGameScreen extends StatefulWidget {
  // 🔹 AGREGADO: parámetro opcional para cargar desde guardado
  final bool loadFromSave;
  const WordStormGameScreen(
      {super.key, this.loadFromSave = false}); // 🔹 CAMBIO

  @override
  State<WordStormGameScreen> createState() => _WordStormGameScreenState();
}

class _WordStormGameScreenState extends State<WordStormGameScreen> {
  final GameTheme gameTheme = lightGameTheme;
  late List<List<SquareModel>> board;
  late String targetWord;
  int score = 0;

  int currentRow = 0;
  int currentColumn = 0;
  bool gameOver = false;

  String? invalidWordMessage;

  @override
  void initState() {
    super.initState();

    // 🔹 CAMBIO: inicialización condicional dependiendo de loadFromSave
    if (widget.loadFromSave) {
      final saved = GameState();
      board = List.generate(
        6,
        (r) => List.generate(5, (c) {
          final sq = SquareModel();
          if (r < saved.currentGrid.length &&
              c < saved.currentGrid[r].length &&
              saved.currentGrid[r][c].isNotEmpty) {
            sq.letter = saved.currentGrid[r][c];
            if (r < saved.currentStatusGrid.length &&
                c < saved.currentStatusGrid[r].length) {
              sq.status = SquareStatus.values[saved.currentStatusGrid[r][c]];
            } else {
              sq.status = SquareStatus.initial;
            }
          }
          return sq;
        }),
      );
      targetWord = saved.targetWord;
      currentRow = saved.currentRow;
      currentColumn = saved.currentCol;
      score = saved.score;
    } else {
      board = List.generate(6, (_) => List.generate(5, (_) => SquareModel()));
      targetWord = fiveLetterWords[Random().nextInt(fiveLetterWords.length)]
          .toUpperCase();
    }
  }

  void updateSquare(int row, int col, String letter, SquareStatus status) {
    board[row][col].letter = letter;
    board[row][col].status = status;
  }

  void startNewGame() {
    setState(() {
      board = List.generate(6, (_) => List.generate(5, (_) => SquareModel()));
      targetWord = fiveLetterWords[Random().nextInt(fiveLetterWords.length)]
          .toUpperCase();
      currentRow = 0;
      currentColumn = 0;
      gameOver = false;
      invalidWordMessage = null;
    });
  }

  void showEndGameDialog({required bool won}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        if (won) {
          return WinDialog(
            targetWord: targetWord,
            onNewGame: () {
              setState(() {
                score++;
              });

              Navigator.of(context).pop();
              startNewGame();
            },
            onGoMenu: () {
              GameState().continueReset();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        } else {
          return LoseDialog(
            targetWord: targetWord,
            onNewGame: () {
              setState(() {
                score = 0;
              });
              Navigator.of(context).pop();
              startNewGame();
            },
            onGoMenu: () {
              GameState().reset();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        }
      },
    );
  }

  void handleKeyPress(String key) {
    if (gameOver) return;

    setState(() {
      if (key == '⌫') {
        if (currentColumn > 0) {
          currentColumn--;
          updateSquare(currentRow, currentColumn, '', SquareStatus.initial);
        }
      } else if (key == 'GO') {
        if (currentColumn == 5) {
          final guess = board[currentRow].map((sq) => sq.letter).join();
          final guessUpper = guess.toUpperCase();

          if (!fiveLetterWords.contains(guess.toLowerCase())) {
            invalidWordMessage = 'Palabra no válida';
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  invalidWordMessage = null;
                });
              }
            });
            return;
          }

          invalidWordMessage = null;

          for (int i = 0; i < 5; i++) {
            final guessLetter = guessUpper[i];
            final targetLetter = targetWord[i];

            if (guessLetter == targetLetter) {
              updateSquare(currentRow, i, guessLetter, SquareStatus.correct);
            } else if (targetWord.contains(guessLetter)) {
              updateSquare(currentRow, i, guessLetter, SquareStatus.present);
            } else {
              updateSquare(currentRow, i, guessLetter, SquareStatus.absent);
            }
          }

          if (guessUpper == targetWord) {
            gameOver = true;
            showEndGameDialog(won: true);
          } else {
            currentRow++;
            currentColumn = 0;
            if (currentRow >= 6) {
              gameOver = true;
              showEndGameDialog(won: false);
            }
          }
        }
      } else {
        if (currentColumn < 5) {
          updateSquare(currentRow, currentColumn, key, SquareStatus.initial);
          currentColumn++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gameTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: gameTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Puntaje: $score',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => OptionsDialog(
                  onNewGame: () {
                    setState(() {
                      score = 0;
                    });
                    startNewGame();
                  },
                  onSaveBeforeExit: () {
                    final gridLetters = board
                        .map((row) => row.map((sq) => sq.letter).toList())
                        .toList();
                    final gridStatus = board
                        .map((row) => row.map((sq) => sq.status.index).toList())
                        .toList();

                    final partialWord = (currentColumn > 0)
                        ? gridLetters[currentRow].take(currentColumn).join()
                        : '';

                    GameState().saveGameState(
                      grid: gridLetters,
                      statusGrid: gridStatus, // nuevo
                      row: currentRow,
                      col: currentColumn,
                      currentScore: score,
                      partialWord: partialWord,
                      answerWord: targetWord,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    GameBoard(board: board, gameTheme: gameTheme),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 17,
                      child: Center(
                        child: invalidWordMessage != null
                            ? Text(
                                invalidWordMessage!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GameKeyboard(onKeyPress: handleKeyPress),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
