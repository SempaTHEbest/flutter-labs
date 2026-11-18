import 'package:flutter/material.dart';

enum ColorChannel { red, green, blue }

/// Стан застосунку: значення каналів R, G, B (0..255).
class ColorModel extends ChangeNotifier {
  static const _initial = (r: 120, g: 80, b: 200);

  int _red = _initial.r;
  int _green = _initial.g;
  int _blue = _initial.b;

  int get red => _red;
  int get green => _green;
  int get blue => _blue;

  Color get color => Color.fromARGB(255, _red, _green, _blue);

  String get hex =>
      '#${[_red, _green, _blue].map((v) => v.toRadixString(16).padLeft(2, '0')).join().toUpperCase()}';

  /// Чи темний колір - щоб підібрати контрастний колір тексту.
  bool get isDark => (0.299 * _red + 0.587 * _green + 0.114 * _blue) < 140;

  int valueOf(ColorChannel channel) => switch (channel) {
        ColorChannel.red => _red,
        ColorChannel.green => _green,
        ColorChannel.blue => _blue,
      };

  void setChannel(ColorChannel channel, int value) {
    final v = value.clamp(0, 255);
    switch (channel) {
      case ColorChannel.red:
        _red = v;
      case ColorChannel.green:
        _green = v;
      case ColorChannel.blue:
        _blue = v;
    }
    notifyListeners();
  }

  void reset() {
    _red = _initial.r;
    _green = _initial.g;
    _blue = _initial.b;
    notifyListeners();
  }
}
