import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_helpers.dart';

void checkTextProperties({
  required final Text textWidget,
  final String? text,
  final TextAlign? textAlign,
  final double? fontSize,
  final Color? textColor,
  final FontWeight? fontWeight,
}) {
  final String widgetName = "Text widget${text != null ? " with text '$text'" : ""}";
  if (textAlign != null) {
    expect(
      textWidget.textAlign,
      isNotNull,
      reason: "$widgetName should have not null TextAlign",
    );
  }
  if (fontSize == null && textColor == null && fontWeight == null) {
    return;
  }
  expect(
    textWidget.style,
    isNotNull,
    reason: "$widgetName should have not null TextStyle",
  );
  final TextStyle notNullTextStyle = textWidget.style!;
  if (fontSize != null) {
    _checkTextStyleProperty<double>(
      widgetName: widgetName,
      property: notNullTextStyle.fontSize,
      propertyName: "fontSize",
      rightValue: fontSize,
    );
  }
  if (textColor != null) {
    _checkTextStyleProperty<Color>(
      widgetName: widgetName,
      property: notNullTextStyle.color,
      propertyName: "color",
      rightValue: textColor,
    );
  }

  if (fontWeight != null) {
    _checkTextStyleProperty<FontWeight>(
      widgetName: widgetName,
      property: notNullTextStyle.fontWeight,
      propertyName: "fontWeight",
      rightValue: fontWeight,
    );
  }
}

void _checkTextStyleProperty<T>({
  required final String widgetName,
  required final T? property,
  required final String propertyName,
  required final T rightValue,
  final T? secondRightValue,
}) {
  expect(
    property,
    isNotNull,
    reason: "The style of $widgetName should have not null $propertyName property",
  );
  expect(
    property,
    secondRightValue != null ? isOneOrAnother(rightValue, secondRightValue) : rightValue,
    reason: "The style of $widgetName should have $propertyName "
        "${secondRightValue != null ? "either $rightValue or $secondRightValue" : rightValue}",
  );
}
