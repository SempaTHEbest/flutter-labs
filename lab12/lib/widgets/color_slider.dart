import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_model.dart';

/// Слайдер одного каналу. Через select перебудовується лише тоді,
/// коли змінюється саме його значення.
class ColorSlider extends StatelessWidget {
  final ColorChannel channel;
  final String label;
  final Color color;

  const ColorSlider({
    super.key,
    required this.channel,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final value = context.select<ColorModel, int>((m) => m.valueOf(channel));

    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: 255,
            divisions: 255,
            activeColor: color,
            label: '$value',
            onChanged: (v) =>
                context.read<ColorModel>().setChannel(channel, v.round()),
          ),
        ),
        SizedBox(
          width: 36,
          child: Text(
            '$value',
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
