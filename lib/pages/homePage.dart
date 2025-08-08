import 'package:flutter/material.dart';
import 'gamePage.dart';
import '../data/game_state.dart';
import '../components/info_dialog.dart';
import '../components/help_dialog.dart';

enum SquareStatus { correct, present, absent }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasSavedGame = false;

  @override
  void initState() {
    super.initState();
    hasSavedGame = GameState().hasSavedGame();
  }

  Widget _buildLetterTile(String letter, Color color) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Courier',
          ),
        ),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (_) => const InfoDialog(),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (_) => const HelpDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colores inspirados en Wordle
    const correctColor = Color(0xFF6AAA64);
    const presentColor = Color(0xFFC9B458);
    const absentColor = Color(0xFF787C7E);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black87),
            tooltip: 'Información',
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLetterTile('W', absentColor),
                    _buildLetterTile('O', absentColor),
                    _buildLetterTile('R', presentColor),
                    _buildLetterTile('D', absentColor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLetterTile('S', correctColor),
                    _buildLetterTile('T', correctColor),
                    _buildLetterTile('O', absentColor),
                    _buildLetterTile('R', presentColor),
                    _buildLetterTile('M', absentColor),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WordStormGameScreen(),
                        ),
                      );
                      setState(() {
                        hasSavedGame = GameState().hasSavedGame();
                      });
                    },
                    child: const Text(
                      "Nuevo Juego",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: hasSavedGame
                        ? () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WordStormGameScreen(
                                    loadFromSave: true),
                              ),
                            );
                            setState(() {
                              hasSavedGame = GameState().hasSavedGame();
                            });
                          }
                        : null,
                    child: const Text(
                      "Continuar",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.help_outline, color: Colors.black87),
                  tooltip: 'Ayuda',
                  onPressed: _showHelpDialog,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                "🏆 Puntaje Record = 12",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
