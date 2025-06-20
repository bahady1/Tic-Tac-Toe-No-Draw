import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Unlimited Tic-Tac-Toe',
    theme: ThemeData.dark().copyWith(
      primaryColor: Colors.tealAccent[200],
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1F1F),
        foregroundColor: Colors.tealAccent,
        elevation: 2,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.tealAccent),
        bodyMedium: TextStyle(color: Colors.white),
        headlineMedium:
        TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold),
      ),
      iconTheme: const IconThemeData(color: Colors.tealAccent),
      dividerColor: Colors.tealAccent,
    ),
    home: const GameScreen(),
  );
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int size = 3;

  List<List<String>> board = List.generate(size, (_) => List.filled(size, ''));

  Map<String, List<Position>> playerMoves = {
    'X': [],
    'O': [],
  };

  String currentPlayer = 'X';
  String? winner;

  Future<void> _playSound(String assetPath) async {
    try {
      final player = AudioPlayer();
      await player.play(AssetSource(assetPath));
      player.onPlayerComplete.listen((_) {
        player.dispose();
      });
    } catch (e) {
      print('Error playing $assetPath: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unlimited Tic-Tac-Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            winner == null ? 'Turn: $currentPlayer' : 'Winner: $winner',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          _buildBoard(),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            icon: const Icon(Icons.refresh, size: 26, color: Colors.tealAccent),
            label: const Text(
              ' Reset  ',
              style: TextStyle(fontSize: 18, color: Colors.tealAccent),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.tealAccent, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              foregroundColor: Colors.tealAccent,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              _playSound('reset.mp3');
              _resetGame();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(size, (row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(size, (col) {
              String cellSymbol = board[row][col];

              bool isOldest = false;
              if (cellSymbol == currentPlayer &&
                  playerMoves[currentPlayer]!.length > 2 &&
                  winner == null) {
                Position oldest = playerMoves[currentPlayer]!.first;
                if (oldest.row == row && oldest.col == col) {
                  isOldest = true;
                }
              }

              Color borderColor = Colors.tealAccent;
              Color xColor = Colors.lightBlueAccent.shade200;
              Color oColor = Colors.redAccent.shade200;
              Color cellTextColor = cellSymbol == 'X' ? xColor : oColor;

              return GestureDetector(
                onTap: winner != null
                    ? null
                    : () {
                  _handleTap(row, col);
                  _checkWin(currentPlayer)? _playSound('ka-ching.mp3') :_playSound('click.mp3');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.all(4),
                  child: Center(
                    child: Opacity(
                      opacity: cellSymbol == currentPlayer && isOldest ? 0.5 : 1.0,
                      child: Text(
                        cellSymbol,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: cellTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  void _handleTap(int row, int col) {
    if (board[row][col] == '') {
      List<Position> moves = playerMoves[currentPlayer]!;

      setState(() {
        if (moves.length < 3) {
          board[row][col] = currentPlayer;
          moves.add(Position(row, col));
        } else {
          Position oldest = moves.removeAt(0);
          board[oldest.row][oldest.col] = '';

          board[row][col] = currentPlayer;
          moves.add(Position(row, col));
        }

        if (_checkWin(currentPlayer)) {

          winner = currentPlayer;
          _playSound('ka-ching.mp3');
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWin(String player) {
    for (int r = 0; r < size; r++) {
      if (board[r].every((cell) => cell == player)) return true;
    }
    for (int c = 0; c < size; c++) {
      bool colWin = true;
      for (int r = 0; r < size; r++) {
        if (board[r][c] != player) {
          colWin = false;
          break;
        }
      }
      if (colWin) return true;
    }
    bool diag1 = true, diag2 = true;
    for (int i = 0; i < size; i++) {
      if (board[i][i] != player) diag1 = false;
      if (board[i][size - i - 1] != player) diag2 = false;
    }
    return diag1 || diag2;
  }

  void _resetGame() {
    setState(() {
      board = List.generate(size, (_) => List.filled(size, ''));
      playerMoves = {
        'X': [],
        'O': [],
      };
      currentPlayer = 'X';
      winner = null;
    });
  }
}

class Position {
  final int row;
  final int col;

  Position(this.row, this.col);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Position && row == other.row && col == other.col;

  @override
  int get hashCode => row.hashCode ^ col.hashCode;
}
