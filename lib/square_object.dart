import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@immutable
class SquareObject {
  late final ValueNotifier<int> _speed;

  ValueListenable<int> get speed => _speed;

  void updateSpeed(int speed) {
    _speed.value = (speed / 10).round();
  }

  SquareObject({
    required int initialSpeed,
  }) : _speed = ValueNotifier<int>(initialSpeed);
}
