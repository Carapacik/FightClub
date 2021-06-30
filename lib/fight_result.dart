import 'package:flutter/painting.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class FightResult {
  final String result;
  final Color color;

  const FightResult._(this.result, this.color);

  static const won = FightResult._("Won", FightClubColors.green);
  static const lost = FightResult._("Lost", FightClubColors.red);
  static const draw = FightResult._("Draw", FightClubColors.blueButton);

  static const values = [won, lost, draw];

  static FightResult getByName(final String name) {
    return values.firstWhere((fightResult) => fightResult.result == name);
  }

  static FightResult? calculateResult(
      final int yourLives, final int enemysLives) {
    if (yourLives == 0 && enemysLives == 0) {
      return draw;
    } else if (yourLives == 0) {
      return lost;
    } else if (enemysLives == 0) {
      return won;
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return "FightResult{result : $result}";
  }
}
