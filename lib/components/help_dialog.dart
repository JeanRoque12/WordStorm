import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '¿Cómo jugar WordStorm?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Adivina la palabra de 5 letras en 6 intentos.\n\n'
              'Cada intento debe ser una palabra válida.\n\n'
              'Los colores indican qué tan cerca estás:\n'
              '- 🟩 Letra en el lugar correcto.\n'
              '- 🟨 Letra en la palabra pero en otro lugar.\n'
              '- ⬜ Letra no está en la palabra.\n\n'
              '¡Buena suerte!',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
        ),
      ),
    );
  }
}
