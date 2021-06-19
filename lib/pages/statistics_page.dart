import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  "Statistics",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: FightClubColors.darkGreyText,
                  ),
                )),
            Expanded(child: SizedBox()),
            Column(
              children: [
                Text(
                  "Won: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: FightClubColors.darkGreyText),
                ),
                SizedBox(height: 6),
                Text(
                  "Draw: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: FightClubColors.darkGreyText),
                ),
                SizedBox(height: 6),
                Text(
                  "Lose: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: FightClubColors.darkGreyText),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SecondaryActionButton(
                onTap: () => Navigator.of(context).pop(),
                text: "Back",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
