import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../container_checks.dart';
import '../test_helpers.dart';
import '../text_checks.dart';

void runTestLecture4hometask2() {
  testWidgets(
      "module2", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryActionButton(onTap: () {}, text: "Statistics"),
        ),
      ),
    );

    final containerFinder = findTypeByTextOnlyInParentType(
        Container, "Statistics".toUpperCase(), SecondaryActionButton);

    final Container container = tester.widget<Container>(containerFinder);

    checkContainerEdgeInsetsProperties(
      container: container,
      margin: EdgeInsetsCheck(left: 16, right: 16),
    );
    checkContainerWidthOrHeightProperties(
      container: container,
      widthAndHeight: WidthAndHeight(width: null, height: 40),
      secondWidthAndHeight: WidthAndHeight(width: double.infinity, height: 40),
    );
    checkContainerAlignment(
      container: container,
      alignment: Alignment.center,
    );
    checkContainerBorder(
      container: container,
      border: Border.all(color: const Color(0xFF161616), width: 2),
    );

    expect(
      container.child,
      isInstanceOf<Text>(),
      reason: "Container should have child of Text type",
    );

    expect(
      (container.child as Text).data,
      "Statistics".toUpperCase(),
      reason: "Text should uppercased text",
    );

    expect(
      (container.child as Text).style,
      isNotNull,
      reason: "Text should have not null style",
    );

    checkTextProperties(
      textWidget: container.child as Text,
      textColor: const Color(0xFF161616),
    );

    await tester.pumpWidget(MyApp());

    final secondaryActionButtonFinder =
        findTypeByTextOnlyInParentType(SecondaryActionButton, "Statistics".toUpperCase(), Column);
    expect(
      secondaryActionButtonFinder,
      findsOneWidget,
      reason: "There are should be a SecondaryActionButton\n"
          "with text 'STATISTICS' in a top-level Column",
    );

    final gestureDetectorFinder = findTypeByTextOnlyInParentType(
        GestureDetector, "Statistics".toUpperCase(), SecondaryActionButton);
    expect(
      gestureDetectorFinder,
      findsOneWidget,
      reason: "There are should be a GestureDetector inside SecondaryActionButton",
    );
  });
}
