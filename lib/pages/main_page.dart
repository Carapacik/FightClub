import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: Text(
                "The\nfight\nclub".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, color: FightClubColors.darkGreyText),
              ),
            ),
            Expanded(child: SizedBox()),
            FutureBuilder<String?>(
                future: SharedPreferences.getInstance().then(
                  (sharedPreferences) =>
                      sharedPreferences.getString("last_fight_result"),
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const SizedBox();
                  }
                  final FightResult fightResult =
                      FightResult.getByName(snapshot.data!);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Last fight result",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: FightClubColors.darkGreyText, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      FightResultWidget(fightResult: fightResult),
                    ],
                  );
                }),
            Expanded(child: SizedBox()),
            SecondaryActionButton(
                onTap: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StatisticsPage(),
                        ),
                      ),
                    },
                text: "Statistics"),
            const SizedBox(height: 16),
            ActionButton(
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FightPage(),
                  ),
                ),
              },
              color: FightClubColors.blackButton,
              text: "Start",
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
