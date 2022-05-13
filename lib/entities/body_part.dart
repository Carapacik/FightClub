import 'dart:math';

enum BodyPart {
  head._('Head'),
  torso._('Torso'),
  legs._('Legs');

  const BodyPart._(this.name);

  final String name;

  @override
  String toString() => 'BodyPart{name: $name}';

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() => _values[Random().nextInt(_values.length)];
}
