import 'package:playing_cards/playing_cards.dart';
import 'dart:math';
import 'card.dart';

class Deck {
  List<GameCard> cards;

  Deck() : cards = [] {
    _initializeDeck();
  }

  void _initializeDeck() {
    cards = standardFiftyTwoCardDeck()
    .map((card) => GameCard(card: card)).toList();

  }

  void shuffle() {
    final random = Random();
    cards.shuffle(random);
  }

  GameCard? drawcard() {
    if (cards.isEmpty) return null;
    return cards.removeLast();
  }

  List<GameCard> drawCards(int count) {
    List<GameCard> drawnCards = [];
    for (int i =0; i < count && cards.isNotEmpty; i++) {
      drawnCards.add(cards.removeLast());
    }
    return drawnCards;
  }

  void reset() {
    _initializeDeck();
  }

  bool get isEmpty => cards.isEmpty;
  int get remainingCards => cards.length;
  }

