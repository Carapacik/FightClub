import 'dart:math';

enum BodyPart {
  head._('Head'),
  torso._('Torso'),
  legs._('Legs');

  const BodyPart._(this.name);

  final String name;

  @override
  String toString() => 'BodyPart{name: $name}';

  static BodyPart get random => values[Random().nextInt(values.length)];
}
