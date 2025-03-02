import 'package:flutter/material.dart';
import 'package:card_game/services/deck_service.dart';
import 'package:card_game/models/deck_model.dart';
import 'package:card_game/models/player_model.dart';
import 'package:card_game/models/card_model.dart';
import 'package:card_game/models/turn_model.dart';

class GameProvider with ChangeNotifier {
  GameProvider() {
    _service = DeckService();
  }

  late DeckService _service;

  late Turn _turn;
  Turn get turn => _turn;

  DeckModel? _currentDeck;
  DeckModel? get currentDeck => _currentDeck;

  List<PlayerModel> _players = [];
  List<PlayerModel> get players => _players;

  List<CardModel> _discards = [];
  List<CardModel> get discards => _discards;
  CardModel? get discardTop => _discards.isEmpty ? null : _discards.last;

  final Map<String, dynamic> _gameState = {};

  Future<void> newGame(List<PlayerModel> players) async {
    final deck = await _service.newDeck();
    _currentDeck = deck;

    _players = players;
    _discards = [];
    _turn = Turn(players: players, currentPlayer: players.first);
    setupBoard();

    notifyListeners();
  }

  Future<void> setupBoard() async {}

  bool get canDrawCards {
    return turn.drawCount < 1;
  }

  Future<void> drawCards(PlayerModel player, {int count = 1}) async {
    if (currentDeck == null) return;
    if (!canDrawCards) return;

    final draw = await _service.drawCards(_currentDeck!, count: count);

    player.addCards(draw.cards);

    _turn.drawCount += count;

    _currentDeck!.remaining = draw.remaining;

    notifyListeners();
  }

  bool canPlayCard(CardModel card) {
    return true;
  }

  Future<void> playCard({
    required PlayerModel player,
    required CardModel card,
  }) async {
    if (!canPlayCard(card)) return;

    player.removeCards(card);

    _discards.add(card);

    await applyCardSideEffects(card);

    _turn.actionCount += 1;

    notifyListeners();
  }

  Future<void> applyCardSideEffects(CardModel card) async {


  }

  bool get canEndTurn {
    return turn.drawCount > 0;
  }

  void endTurn() {
    _turn.nextTurn();

    if (_turn.currentPlayer!.isBot) {
      botTurn();
    }
    notifyListeners();
  }

  void botTurn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await drawCards(_turn.currentPlayer!);

    if (_turn.currentPlayer!.cards.isNotEmpty) {
      playCard(player: _turn.currentPlayer!, card: _turn.currentPlayer!.cards.first);
    }

    if (canEndTurn) {
      endTurn();
    }
  }
}
