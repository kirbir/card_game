import 'package:flutter/material.dart';
import 'package:card_game/game.dart';
import 'package:card_game/models/deck.dart';
import '../models/player.dart';
import '../models/game_state.dart';
import 'package:card_game/game.dart';
import 'package:playing_cards/playing_cards.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;

  @override
  void initState() {
    super.initState();
    game = Game(
      player: Player(name: 'Player'),
      player2: Player(name: 'Player 2'),
    );
    game.addListener(_onGameStateChanged);
    game.startGame();
    print('Player hand size: ${game.player.handSize}');
    print('Player 2 hand size: ${game.player2.handSize}');
  }

  void _onGameStateChanged() {
    setState(() {});
  }

  // CARD STYLES // CARD STYLES // CARD STYLES
   PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(
    suitStyles: {
      Suit.spades: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "♠",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.hearts: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "♥",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.diamonds: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "♦",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.clubs: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♣",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.joker: SuitStyle(builder: (context) => Container()),
    },
  );
// CARD STYLES // CARD STYLES // CARD STYLES

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 117, 112, 112),
      body: Column(

        children: [
          
          // Computer's cards (face down)
          _buildPlayerHand(game.player2, isComputer: true),
          
      
          // Middle section (deck, discard pile, etc)
          _buildGameSection(),
          
          // Player's cards
          _buildPlayerHand(game.player, isComputer: false),
        ],
      ),
    );
  }

  Widget _buildPlayerHand(Player player, {required bool isComputer}) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.green[700],
      child: Column(
        children: [
          Text(
            '${player.name} (${player.handSize} cards)',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: player.hand.length,
              itemBuilder: (context, index) {
                final card = player.hand[index];
                print('Rendering card: ${card.suit} ${card.value}');
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    width: 80,
                    child: PlayingCardView(
                      card: card.card,
                      showBack: !card.isVisible || isComputer,
                      style: PlayingCardViewStyle(
                        suitStyles: {
                          Suit.spades: SuitStyle(
                            builder: (context) => const Text("♠", style: TextStyle(fontSize: 30)),
                            style: const TextStyle(color: Colors.black),
                          ),
                          Suit.hearts: SuitStyle(
                            builder: (context) => const Text("♥", style: TextStyle(fontSize: 30, color: Colors.red)),
                            style: const TextStyle(color: Colors.red),
                          ),
                          Suit.diamonds: SuitStyle(
                            builder: (context) => const Text("♦", style: TextStyle(fontSize: 30, color: Colors.red)),
                            style: const TextStyle(color: Colors.red),
                          ),
                          Suit.clubs: SuitStyle(
                            builder: (context) => const Text("♣", style: TextStyle(fontSize: 30)),
                            style: const TextStyle(color: Colors.black),
                          ),
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
Widget _buildGameSection() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Deck pile
        GestureDetector(
          onTap: () {
            // Handle drawing a card
            if (game.currentState == GameState.playerTurn) {
              // TODO: Implement draw card logic
     
            }
          },
          child: Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 38, 50, 60),
            ),
            child: Center(
              child: Text(
                '${game.deck.remainingCards}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        // Game status
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current Turn',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              game.currentState == GameState.playerTurn ? 'Player 1\'s Turn' : 'Player 2\'s Turn',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),

        // Discard pile (placeholder for now)
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade200,
          ),
          child: const Center(
            child: Text(
              'Discard',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}