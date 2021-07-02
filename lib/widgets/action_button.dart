import 'package:fightclub/resources/fight_club_colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const ActionButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: FightClubColors.whiteText),
        ),
      ),
    );
  }
}
