import 'package:card_game/models/player_model.dart';

class Turn {
  final List<PlayerModel> players;
  int index;
  PlayerModel? currentPlayer;
  int drawCount;
  int actionCount;

  Turn(
      {required this.players,
      this.currentPlayer,
      this.index = 0,
      this.drawCount = 0,
      this.actionCount = 0});

      void nextTurn() {
        index += 1;
        // Update logic if more than 2 players
        currentPlayer = index % 2 == 0 ? players[0] : players[1];
        drawCount = 0;
        actionCount = 0;
      }

      PlayerModel get otherPlayer {
        return players.firstWhere((p) => p != currentPlayer);
      }
}
