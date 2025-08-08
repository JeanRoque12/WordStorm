// lib/widgets/keyboard.dart
import 'package:flutter/material.dart';

class GameKeyboard extends StatelessWidget {
  final void Function(String key) onKeyPress;

  const GameKeyboard({super.key, required this.onKeyPress});

  Widget buildKey(String label, {double flex = 1}) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () => onKeyPress(label),
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0), // <- Fix spacing
              backgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: label == '⌫'
                ? const Icon(Icons.backspace_outlined)
                : Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        textAlign: TextAlign.center, // <- Fix text alignment
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'YourCustomFont', // Optional spooky font
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(List<String> keys, {List<int>? flexes}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: List.generate(keys.length, (i) {
          final key = keys[i];
          final flex = flexes != null && flexes.length > i ? flexes[i] : 1;
          return buildKey(key, flex: flex.toDouble());
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildRow('QWERTYUIOP'.split('')),
        buildRow('ASDFGHJKL'.split('')),
        buildRow(
          ['GO', ...'ZXCVBNM'.split(''), '⌫'],
          flexes: [2, 1, 1, 1, 1, 1, 1, 1, 2], // Make GO and backspace wider
        ),
      ],
    );
  }
}
