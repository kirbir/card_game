import 'package:flutter/material.dart';
import 'package:card_game/models/card_model.dart';
import 'package:card_game/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_game/components/card_back.dart';

class PlayingCard extends StatelessWidget {
  final CardModel card;
  final double size;
  final bool visible;
  final Function (CardModel)? onPlayCard;

  const PlayingCard(
      {super.key, required this.card, this.size = 0.5, this.visible = true, this.onPlayCard});


 Widget _buildFrontCard() {
    print('trying to display image');
    return CachedNetworkImage(
      imageUrl: card.image,
      width: CARD_WIDTH * size,
      height: CARD_HEIGHT * size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPlayCard != null) {
          onPlayCard!(card);
        }
      },
      child: Container(
        width: CARD_WIDTH * size,
        height: CARD_HEIGHT * size,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          
        ),
        clipBehavior: Clip.antiAlias,
        child: visible
            ? _buildFrontCard()
            : CardBack(size: size),
      ),
    );
  }
}
