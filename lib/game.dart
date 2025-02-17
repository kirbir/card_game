import 'package:flutter/material.dart';
import 'package:card_game/models/deck.dart';
import 'package:card_game/models/card.dart';
import 'package:card_game/models/player.dart';
import 'package:card_game/models/game_state.dart';

class Game extends ChangeNotifier {
  final Deck deck;
  final Player player;
  final Player computer;
  GameState currentState;
  
  Game({
    required this.player,
    required this.computer,
  }) : deck = Deck(),
       currentState = GameState.initial;
  
  void startGame() {
    deck.shuffle();
    dealInitialCards();
  }
  
  void dealInitialCards() {
    // Deal face down cards
    currentState = GameState.dealingFaceDown;
    for (int i = 0; i < 3; i++) {
      var playerCard = deck.drawcard();
      var computerCard = deck.drawcard();
      
      if (playerCard != null) {
        playerCard.isVisible = false;
        player.addCard(playerCard);
      }
      
      if (computerCard != null) {
        computerCard.isVisible = false;
        computer.addCard(computerCard);
      }
    }
    
    // Deal face up cards
    currentState = GameState.dealingFaceUp;
    for (int i = 0; i < 3; i++) {
      var playerCard = deck.drawcard();
      var computerCard = deck.drawcard();
      
      if (playerCard != null) {
        playerCard.isVisible = true;
        player.addCard(playerCard);
      }
      
      if (computerCard != null) {
        computerCard.isVisible = true;
        computer.addCard(computerCard);
      }
    }
    
    currentState = GameState.playerTurn;
    notifyListeners();
  }
}