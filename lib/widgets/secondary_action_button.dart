import 'package:fightclub/resources/fight_club_colors.dart';
import 'package:flutter/material.dart';

class SecondaryActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SecondaryActionButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: FightClubColors.darkGreyText, width: 2)),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            color: FightClubColors.darkGreyText,
          ),
        ),
      ),
    );
  }
}
