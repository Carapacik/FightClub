import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../container_checks.dart';
import '../test_helpers.dart';
import '../text_checks.dart';

void runTestLecture4hometask1() {
  testWidgets('module1', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final containerFinder =
        findTypeByTextOnlyInParentType(Container, "Statistics".toUpperCase(), Column);
    expect(
      containerFinder,
      isNotNull,
      reason: "There are should be a Container with text 'STATISTICS' in Column",
    );

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

    checkTextProperties(
      textWidget: container.child as Text,
      textColor: const Color(0xFF161616),
    );
  });
}
