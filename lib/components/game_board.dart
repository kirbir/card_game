import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_game/providers/game_provider.dart';
import 'package:card_game/models/player_model.dart';
import 'package:card_game/components/deck_pile.dart';
import 'package:card_game/components/cart_list.dart';
import 'package:card_game/components/discard_pile.dart';
import 'package:card_game/models/card_model.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // Gives access to the game provider
    return Consumer<GameProvider>(builder: (context, model, child) {
      return model.currentDeck != null
          ? Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            await model.drawCards(model.turn.currentPlayer!);
                          },
                          child: DeckPile(
                              remaining: model.currentDeck!.remaining)),
                      const SizedBox(width: 8),
                      DiscardPile(cards: model.discards),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: CardList(player: model.players[1])),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (model.turn.currentPlayer == model.players[0])
                              ElevatedButton(
                                  onPressed: model.canEndTurn
                                      ? () {
                                          model.endTurn();
                                        }
                                      : null,
                                  child: const Text('End turn')),
                          ],
                        ),
                      ),
                      CardList(
                        player: model.players[0],
                        onPlayCard: (CardModel card) {
                          model.playCard(player: model.players[0], card: card);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: TextButton(
                  onPressed: () {
                    final players = [
                      PlayerModel(name: 'Birkir', isHuman: true),
                      PlayerModel(name: 'Bot', isHuman: false),
                    ];
                    model.newGame(players);
                  },
                  child: Text('NEW GAME?')));
    });
  }
}
