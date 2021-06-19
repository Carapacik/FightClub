import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_icons.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FightPage extends StatefulWidget {
  const FightPage({Key? key}) : super(key: key);

  @override
  FightPageState createState() => FightPageState();
}

class FightPageState extends State<FightPage> {
  static const int maxLives = 5;
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyDefends = BodyPart.random();
  BodyPart whatEnemyAttacks = BodyPart.random();

  int yourLives = maxLives;
  int enemysLives = maxLives;

  String centerText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemysLivesCount: enemysLives,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: ColoredBox(
                  color: FightClubColors.darkPurple,
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        centerText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, color: FightClubColors.darkGreyText),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ControlsWidget(
                defendingBodyPart: defendingBodyPart,
                selectDefendingBodyPart: _selectDefendingBodyPart,
                attackingBodyPart: attackingBodyPart,
                selectAttackingBodyPart: _selectAttackingBodyPart),
            SizedBox(height: 14),
            ActionButton(
              text: _isLivesCountZero() ? "Back" : "Go",
              onTap: _onGoButtonClicked,
              color: _getGoButtonColor(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Color _getGoButtonColor() {
    if (_isLivesCountZero()) {
      return FightClubColors.blackButton;
    } else if (!_isAllBodyPartsSelected()) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  bool _isAllBodyPartsSelected() {
    return defendingBodyPart != null && attackingBodyPart != null;
  }

  bool _isLivesCountZero() {
    return yourLives == 0 || enemysLives == 0;
  }

  void _onGoButtonClicked() {
    if (_isLivesCountZero()) {
      Navigator.of(context).pop();
    } else if (_isAllBodyPartsSelected()) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLoseLife) {
          enemysLives--;
        }
        if (youLoseLife) {
          yourLives--;
        }

        final FightResult? fightResult =
            FightResult.calculateResult(yourLives, enemysLives);
        if (fightResult != null) {
          SharedPreferences.getInstance().then((sharedPreferences) {
            sharedPreferences.setString(
                "last_fight_result", fightResult.result);
          });
        }
        if (fightResult == FightResult.won) {
          SharedPreferences.getInstance().then((sharedPreferences) {
            sharedPreferences.setInt("stats_won", 1);
          });
        } else if (fightResult == FightResult.draw) {
          SharedPreferences.getInstance().then((sharedPreferences) {
            sharedPreferences.setInt("stats_draw", 1);
          });
        } else if (fightResult == FightResult.lost) {
          SharedPreferences.getInstance().then((sharedPreferences) {
            sharedPreferences.setInt("stats_lost", 1);
          });
        }

        centerText = _calculateCenterText(youLoseLife, enemyLoseLife);

        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();

        defendingBodyPart = null;
        attackingBodyPart = null;
      });
    }
  }

  String _calculateCenterText(
      final bool youLoseLife, final bool enemyLoseLife) {
    if (yourLives == 0 && enemysLives == 0) {
      return "Draw";
    } else if (enemysLives == 0) {
      return "You won";
    } else if (yourLives == 0) {
      return "You lost";
    } else {
      final String first = enemyLoseLife
          ? "You hit enemy's ${attackingBodyPart!.name.toLowerCase()}."
          : "Your attack was blocked.";
      final String second = youLoseLife
          ? "Enemy hit your ${whatEnemyAttacks.name.toLowerCase()}."
          : "Enemy's attack was blocked.";

      return "$first\n$second";
    }
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    if (_isLivesCountZero()) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    if (_isLivesCountZero()) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({
    Key? key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attackingBodyPart,
    required this.selectAttackingBodyPart,
  }) : super(key: key);

  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(width: 16),
      Expanded(
        child: Column(
          children: [
            Text(
              "Defend".toUpperCase(),
              style: TextStyle(color: FightClubColors.darkGreyText),
            ),
            SizedBox(height: 13),
            BodyPartButton(
              bodyPart: BodyPart.head,
              selected: defendingBodyPart == BodyPart.head,
              bodyPartSetter: selectDefendingBodyPart,
            ),
            SizedBox(height: 14),
            BodyPartButton(
              bodyPart: BodyPart.torso,
              selected: defendingBodyPart == BodyPart.torso,
              bodyPartSetter: selectDefendingBodyPart,
            ),
            SizedBox(height: 14),
            BodyPartButton(
              bodyPart: BodyPart.legs,
              selected: defendingBodyPart == BodyPart.legs,
              bodyPartSetter: selectDefendingBodyPart,
            ),
          ],
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          children: [
            Text(
              "Attack".toUpperCase(),
              style: TextStyle(color: FightClubColors.darkGreyText),
            ),
            SizedBox(height: 13),
            BodyPartButton(
              bodyPart: BodyPart.head,
              selected: attackingBodyPart == BodyPart.head,
              bodyPartSetter: selectAttackingBodyPart,
            ),
            SizedBox(height: 14),
            BodyPartButton(
              bodyPart: BodyPart.torso,
              selected: attackingBodyPart == BodyPart.torso,
              bodyPartSetter: selectAttackingBodyPart,
            ),
            SizedBox(height: 14),
            BodyPartButton(
              bodyPart: BodyPart.legs,
              selected: attackingBodyPart == BodyPart.legs,
              bodyPartSetter: selectAttackingBodyPart,
            ),
          ],
        ),
      ),
      SizedBox(width: 16),
    ]);
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemysLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemysLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LivesWidget(
                overallLivesCount: maxLivesCount,
                currentLivesCount: yourLivesCount,
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "You",
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  const SizedBox(height: 12),
                  Image.asset(
                    FightClubImages.youAvatar,
                    width: 92,
                    height: 92,
                  )
                ],
              ),
              SizedBox(
                height: 44,
                width: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FightClubColors.blueButton),
                  child: Center(
                    child: Text(
                      "vs",
                      style: TextStyle(
                          color: FightClubColors.whiteText, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Enemy",
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  const SizedBox(height: 12),
                  Image.asset(
                    FightClubImages.enemyAvatar,
                    width: 92,
                    height: 92,
                  )
                ],
              ),
              LivesWidget(
                overallLivesCount: maxLivesCount,
                currentLivesCount: enemysLivesCount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LivesWidget extends StatelessWidget {
  const LivesWidget(
      {Key? key,
      required this.overallLivesCount,
      required this.currentLivesCount})
      : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);
  final int overallLivesCount;
  final int currentLivesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(overallLivesCount, (index) {
        if (index < currentLivesCount) {
          return [
            Image.asset(FightClubIcons.heartFull, width: 18, height: 18),
            if (overallLivesCount - 1 > index) SizedBox(height: 4),
          ];
        } else {
          return [
            Image.asset(FightClubIcons.heartEmpty, width: 18, height: 18),
            if (overallLivesCount - 1 > index) SizedBox(height: 4),
          ];
        }
      }).expand((element) => element).toList(),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected ? FightClubColors.blueButton : Colors.transparent,
            border: !selected
                ? Border.all(color: FightClubColors.darkGreyText, width: 2)
                : null,
          ),
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: selected
                    ? FightClubColors.whiteText
                    : FightClubColors.darkGreyText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
