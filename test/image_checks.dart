import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void checkImageProperties({
  required final Image image,
  final double? height,
  final double? width,
  final BoxFit? boxFit,
  final ImageProvider? imageProvider,
}) {
  final String widgetName = "Image";
  if (height != null) {
    expect(
      image.height,
      isNotNull,
      reason: "$widgetName should have not null property height",
    );
    expect(
      image.height,
      height,
      reason: "$widgetName should have height property of $height",
    );
  }
  if (width != null) {
    expect(
      image.width,
      isNotNull,
      reason: "$widgetName should have not null property width",
    );
    expect(
      image.width,
      width,
      reason: "$widgetName should have width property of $height",
    );
  }

  if (boxFit != null) {
    expect(
      image.fit,
      isNotNull,
      reason: "$widgetName should have not null property fit",
    );
    expect(
      image.fit,
      boxFit,
      reason: "$widgetName should have fit property of $boxFit",
    );
  }
  if (imageProvider != null) {
    expect(
      image.image,
      imageProvider,
      reason: "$widgetName should have image property of $imageProvider",
    );
  }
}
