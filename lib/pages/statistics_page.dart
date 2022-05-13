import 'package:fightclub/resources/app_colors.dart';
import 'package:fightclub/utils.dart';
import 'package:fightclub/widgets/secondary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: const Text(
                      'Statistics',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.darkGreyText,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }
                      final sp = snapshot.requireData;
                      appearReview();
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Won: ${sp.getInt("stats_won") ?? 0}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGreyText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Lost: ${sp.getInt("stats_lost") ?? 0}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGreyText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Draw: ${sp.getInt("stats_draw") ?? 0}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGreyText,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SecondaryActionButton(
                      onTap: () => Navigator.of(context).pop(),
                      text: 'Back',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
