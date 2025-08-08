import 'package:flutter/material.dart';
import 'help_dialog.dart';

class OptionsDialog extends StatelessWidget {
  final VoidCallback? onNewGame;
  final VoidCallback? onSaveBeforeExit;

  const OptionsDialog({
    super.key,
    this.onNewGame,
    this.onSaveBeforeExit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildButton(
              context,
              label: 'Continuar',
              color: Colors.green,
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 12),
            _buildButton(
              context,
              label: 'Nuevo Juego',
              color: Colors.yellow.shade700,
              onPressed: () {
                Navigator.of(context).pop();
                if (onNewGame != null) onNewGame!();
              },
            ),
            const SizedBox(height: 12),
            _buildButton(
              context,
              label: 'Ir al menú',
              color: Colors.grey,
              onPressed: () {
                // 🔹 AGREGADO: Guardar antes de salir
                if (onSaveBeforeExit != null) onSaveBeforeExit!();

                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Regresa al menú
              },
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.help_outline),
              tooltip: '¿Cómo jugar?',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const HelpDialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
