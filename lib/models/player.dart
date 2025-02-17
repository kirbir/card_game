import 'card.dart';

class Player {
  final String name;
  List<GameCard> hand;
  int score;
  
  Player({
    required this.name,
    List<GameCard>? hand,
    this.score = 0,
  }) : hand = hand ?? [];
  
  void addCard(GameCard card) {
    hand.add(card);
  }
  
  void addCards(List<GameCard> cards) {
    hand.addAll(cards);
  }
  
  List<GameCard> removeCards(List<GameCard> cardsToRemove) {
    hand.removeWhere((card) => cardsToRemove.contains(card));
    return cardsToRemove;
  }
  
  void clearHand() {
    hand.clear();
  }
  
  int get handSize => hand.length;
}