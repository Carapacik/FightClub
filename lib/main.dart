import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const int maxLives = 5;
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyDefends = BodyPart.random();
  BodyPart whatEnemyAttacks = BodyPart.random();

  int yourLives = maxLives;
  int enemysLives = maxLives;

  String description = "";

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
                child: SizedBox(
                  width: double.infinity,
                  child: ColoredBox(
                    color: FightClubColors.descriptionBackground,
                    child: Center(
                      child: Text(
                        _getDescription(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
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
            GoButton(
              text: _isLivesCountZero() ? "Start new game" : "Go",
              onTap: _onGoButtonClicked,
              color: _getGoButtonColor(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _getDescription() {
    if (yourLives == 0 && enemysLives == 0) {
      return "Draw";
    }
    if (enemysLives == 0) {
      return "You won";
    }
    if (yourLives == 0) {
      return "You lost";
    }
    return description;
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
    description = "";
    if (_isLivesCountZero()) {
      setState(() {
        yourLives = maxLives;
        enemysLives = maxLives;
      });
    } else if (_isAllBodyPartsSelected()) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

        // Логика изменения теста описания
        if (!enemyLoseLife) {
          description += "Your attack was blocked.";
        } else {
          description +=
              "You hit enemy’s ${attackingBodyPart!.name.toLowerCase()}.";
        }

        if (!youLoseLife) {
          description += "\nEnemy’s attack was blocked.";
        } else {
          description +=
              "\nEnemy hit your ${whatEnemyAttacks.name.toLowerCase()}.";
        }

        if (enemyLoseLife) {
          enemysLives--;
        }
        if (youLoseLife) {
          yourLives--;
        }

        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();

        defendingBodyPart = null;
        attackingBodyPart = null;
      });
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

class GoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: FightClubColors.whiteText),
              ),
            ),
          ),
        ),
      ),
    );
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
            Text("Attack".toUpperCase(),
              style: TextStyle(color: FightClubColors.darkGreyText),),
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
              Expanded(
                child: ColoredBox(
                  color: Colors.white,
                  child: SizedBox(height: 160),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Color(0xFFC5D1EA),
                  child: SizedBox(height: 160),
                ),
              )
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
                  Text("You",
                    style: TextStyle(color: FightClubColors.darkGreyText),),
                  const SizedBox(height: 12),
                  Image.asset(
                    FightClubImages.youAvatar,
                    width: 92,
                    height: 92,
                  )
                ],
              ),
              ColoredBox(
                  color: Colors.green, child: SizedBox(height: 44, width: 44)),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text("Enemy",
                    style: TextStyle(color: FightClubColors.darkGreyText),),
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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Image.asset(
              FightClubIcons.heartEmpty,
              width: 18,
              height: 18,
            ),
          );
        }
      }),
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
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
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
