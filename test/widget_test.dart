import 'package:flutter_test/flutter_test.dart';

import '1_module.dart';
import '2_module.dart';
import '3_module.dart';
import '4_module.dart';

void main() {
  group("l04h01", () => module1());
  group("l04h02", () => module2());
  group("l04h03", () => module3());
  group("l04h04", () => module4());
}
