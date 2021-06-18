import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_fight_club/pages/main_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../container_checks.dart';
import '../test_helpers.dart';
import '../text_checks.dart';

void runTestLecture4hometask4() {
  testWidgets(
      'module4', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final secondaryActionButtonFinder =
        findTypeByTextOnlyInParentType(SecondaryActionButton, "Statistics".toUpperCase(), Column);

    expect(
      find.byType(MainPage),
      findsOneWidget,
      reason: "First page should be MainPage",
    );

    expect(
      secondaryActionButtonFinder,
      findsOneWidget,
      reason: "There are should be a SecondaryActionButton with text 'Statistics' in Column",
    );

    await tester.tap(secondaryActionButtonFinder);
    await tester.pumpAndSettle();

    expect(
      find.byType(StatisticsPage),
      findsOneWidget,
      reason: "Statistics should be opened after tap on 'STATISTICS' button",
    );
    final columnFinder = findTypeByTextOnlyInParentType(Column, "Statistics", StatisticsPage);

    expect(
      columnFinder,
      findsOneWidget,
      reason: "There should be a Column widget",
    );

    final Column column = tester.widget(columnFinder);

    expect(
      column.children.first,
      isInstanceOf<Container>(),
      reason: "First widget in Column should be Container",
    );

    final containerWithTitle = column.children.first as Container;

    checkContainerEdgeInsetsProperties(
      container: containerWithTitle,
      paddingOrMargin: EdgeInsetsCheck(top: 24),
    );

    expect(
      containerWithTitle.child,
      isInstanceOf<Text>(),
      reason: "Container's child should be of Text type",
    );

    checkTextProperties(
      textWidget: containerWithTitle.child as Text,
      text: "Statistics",
      textColor: const Color(0xFF161616),
      fontSize: 24,
    );

    final Widget lastWidgetInColumn = column.children.last;
    expect(
      lastWidgetInColumn,
      isInstanceOf<Padding>(),
      reason: "Last widget in Column should have type of Padding",
    );
    expect(
      (lastWidgetInColumn as Padding).padding,
      isInstanceOf<EdgeInsets>(),
      reason: "Padding should have padding property type of EdgeInsets",
    );
    expect(
      (lastWidgetInColumn.padding as EdgeInsets).bottom,
      16,
      reason: "Padding should have bottom padding of 16",
    );
    expect(lastWidgetInColumn.child, isNotNull, reason: "Padding should have not null child");

    final Widget paddingChild = lastWidgetInColumn.child!;
    expect(
      paddingChild,
      isInstanceOf<SecondaryActionButton>(),
      reason: "Padding's child should have type of SecondaryActionButton",
    );
    final SecondaryActionButton secondaryActionButton = paddingChild as SecondaryActionButton;
    expect(
      secondaryActionButton.text,
      "Back",
      reason: "SecondaryActionButton should have text 'Back'",
    );

    await tester.tap(find.text("BACK"));
    await tester.pumpAndSettle();

    expect(
      find.byType(MainPage),
      findsOneWidget,
      reason: "After tapping on Back we should be return to the MainPage",
    );
  });
}
