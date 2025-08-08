import 'package:flutter/material.dart';

class WinDialog extends StatelessWidget {
  final String targetWord;
  final VoidCallback onNewGame;
  final VoidCallback onGoMenu;

  const WinDialog({
    Key? key,
    required this.targetWord,
    required this.onNewGame,
    required this.onGoMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '¡Ganaste!',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text('La palabra era: $targetWord'),
      actions: [
        TextButton(
          onPressed: onNewGame,
          child: const Text('Nuevo juego'),
        ),
        TextButton(
          onPressed: onGoMenu,
          child: const Text('Ir al menú'),
        ),
      ],
    );
  }
}
