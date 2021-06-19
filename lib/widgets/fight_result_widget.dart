import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;

  const FightResultWidget({
    Key? key,
    required this.fightResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: ColoredBox(color: FightClubColors.white)),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FightClubColors.white,
                        FightClubColors.darkPurple
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: ColoredBox(color: FightClubColors.darkPurple))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "You",
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    FightClubImages.youAvatar,
                    width: 92,
                    height: 92,
                  )
                ],
              ),
              Container(
                height: 44,
                width: 72,
                decoration: BoxDecoration(
                  color: _getColor(fightResult),
                  borderRadius: BorderRadius.circular(22),
                ),
                margin: EdgeInsets.symmetric(horizontal: 22),
                child: Center(
                  child: Text(
                    fightResult.result.toLowerCase(),style: TextStyle(
                    color: FightClubColors.white
                  ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "Enemy",
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    FightClubImages.enemyAvatar,
                    width: 92,
                    height: 92,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColor(FightResult fightResult) {
    if (fightResult == FightResult.won) {
      return Color(0xFF038800);
    } else if (fightResult == FightResult.lost) {
      return Color(0xFFEA2C2C);
    } else {
      return Color(0xFF1C79CE);
    }
  }
}
