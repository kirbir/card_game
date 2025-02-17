import 'package:playing_cards/playing_cards.dart';

class GameCard {
  final PlayingCard card;
  bool isVisible;
  bool isSelected;

  GameCard({required this.card, this.isVisible = true, this.isSelected = false});

  // Convenience getters

  Suit get suit => card.suit;
  CardValue get value => card.value;

  // Helper methods
  void flip() {
    isVisible = !isVisible; 
  }

  void toggleSelection() {
    isSelected = !isSelected;
  }

  // Value comparison for game rules

  int getValue() {
    switch (value) {
      case CardValue.ace:
      return 11;
      case CardValue.king:
      case CardValue.queen:
      case CardValue.jack:
      return 10;
      default:
      return value.index + 1;
    }
  }

  // Override toString for debugging
  
}
