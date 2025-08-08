import 'package:flutter/material.dart';

/// Estado de cada casilla en el tablero
enum SquareStatus {
  initial, // Casilla vacía
  correct, // Letra correcta en la posición correcta (verde)
  present, // Letra está en la palabra, pero en otra posición (amarillo)
  absent // Letra no está en la palabra (gris)
}

/// Tema del juego
class GameTheme {
  final Color tileColor;
  final Color correctColor;
  final Color presentColor;
  final Color absentColor;
  final Color backgroundColor;
  final TextStyle letterStyle;

  const GameTheme({
    required this.tileColor,
    required this.correctColor,
    required this.presentColor,
    required this.absentColor,
    required this.backgroundColor,
    required this.letterStyle,
  });
}

/// Tema claro del juego
const lightGameTheme = GameTheme(
  tileColor: Colors.white,
  correctColor: Colors.green,
  presentColor: Colors.yellow,
  absentColor: Colors.grey,
  backgroundColor: Color(0xFFEFEFEF),
  letterStyle: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black,
  ),
);

/// Tema oscuro del juego
const darkGameTheme = GameTheme(
  tileColor: Color(0xFF2D2D2D), // gris oscuro para casillas
  correctColor: Color(0xFF4CAF50), // verde oscuro
  presentColor: Color(0xFFFFC107), // amarillo mostaza
  absentColor: Color(0xFF616161), // gris medio
  backgroundColor: Color(0xFF121212), // fondo casi negro
  letterStyle: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.white,
  ),
);
