import 'package:flutter_test/flutter_test.dart';

import 'lesson_four/test_lesson_four_1.dart';
import 'lesson_four/test_lesson_four_2.dart';
import 'lesson_four/test_lesson_four_3.dart';
import 'lesson_four/test_lesson_four_4.dart';

void main() {
  group("l04h01", () => runTestLecture4hometask1());
  group("l04h02", () => runTestLecture4hometask2());
  group("l04h03", () => runTestLecture4hometask3());
  group("l04h04", () => runTestLecture4hometask4());
}