import 'package:fightclub/fight_result.dart';
import 'package:fightclub/pages/fight_page.dart';
import 'package:fightclub/pages/statistics_page.dart';
import 'package:fightclub/resources/fight_club_colors.dart';
import 'package:fightclub/widgets/action_button.dart';
import 'package:fightclub/widgets/fight_result_widget.dart';
import 'package:fightclub/widgets/secondary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatefulWidget {
  @override
  __MainPageContentState createState() => __MainPageContentState();
}

class __MainPageContentState extends State<_MainPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    "The\nfight\nclub".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30, color: FightClubColors.darkGreyText),
                  ),
                ),
                const Expanded(child: SizedBox()),
                FutureBuilder<String?>(
                  future: SharedPreferences.getInstance().then(
                    (sharedPreferences) => sharedPreferences.getString("last_fight_result"),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const SizedBox();
                    }
                    final FightResult fightResult = FightResult.getByName(snapshot.data!);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Last fight result",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: FightClubColors.darkGreyText, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        FightResultWidget(fightResult: fightResult),
                      ],
                    );
                  },
                ),
                const Expanded(child: SizedBox()),
                SecondaryActionButton(
                  text: "Statistics",
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const StatisticsPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ActionButton(
                  onTap: () async {
                     await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FightPage(),
                      ),
                    );
                    setState(() {});
                  },
                  color: FightClubColors.blackButton,
                  text: "Start",
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
