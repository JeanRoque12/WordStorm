// lib/widgets/game_board.dart
import 'package:flutter/material.dart';
import '../data/themes.dart';

class SquareModel {
  String letter;
  SquareStatus status;

  SquareModel({this.letter = '', this.status = SquareStatus.initial});

  // Método para clonar
  SquareModel copy() {
    return SquareModel(
      letter: letter,
      status: status,
    );
  }
}

class GameBoard extends StatelessWidget {
  final List<List<SquareModel>> board;
  final GameTheme gameTheme;

  const GameBoard({
    super.key,
    required this.board,
    required this.gameTheme,
  });

  Widget _buildSquare(int row, int col) {
    final model = board[row][col];

    Color tileColor;
    switch (model.status) {
      case SquareStatus.correct:
        tileColor = gameTheme.correctColor;
        break;
      case SquareStatus.present:
        tileColor = gameTheme.presentColor;
        break;
      case SquareStatus.absent: // antes era incorrect
        tileColor = gameTheme.absentColor;
        break;
      case SquareStatus.initial: // antes era empty
      default:
        tileColor = gameTheme.tileColor;
    }

    return Container(
      key: ValueKey("square_${row}_$col"),
      width: 55,
      height: 55,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: tileColor,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          model.letter,
          style: gameTheme.letterStyle,
        ),
      ),
    );
  }

  Widget _buildRow(int row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (col) => _buildSquare(row, col)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (row) => _buildRow(row)),
    );
  }
}
