import 'package:flutter_test/flutter_test.dart';

import '1_module.dart';
import '2_module.dart';
import '3_module.dart';
import '4_module.dart';

void main() {
  group("l1", () => module1());
  group("l2", () => module2());
  group("l3", () => module3());
  group("l4", () => module4());
}
