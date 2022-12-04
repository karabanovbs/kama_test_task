import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SquareController {
  final void Function(int speed) onSpeedChanged;

  SquareController(this.onSpeedChanged);

  final HardwareKeyboard hardwareKeyboard = HardwareKeyboard.instance;

  init() {
    hardwareKeyboard.addHandler(_onKeyPressed);
  }

  dispose() {
    hardwareKeyboard.removeHandler(_onKeyPressed);
  }

  bool _onKeyPressed(KeyEvent event) {
    switch (event.character) {
      case '1':
        onSpeedChanged(10);
        break;
      case '2':
        onSpeedChanged(20);
        break;
      case '3':
        onSpeedChanged(30);
        break;
      case '4':
        onSpeedChanged(40);
        break;
    }

    return false;
  }
}
