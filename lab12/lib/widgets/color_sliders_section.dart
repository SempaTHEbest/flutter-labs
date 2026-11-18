import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_model.dart';
import 'color_slider.dart';

/// Секція зі слайдерами R, G, B та кнопкою скидання.
class ColorSlidersSection extends StatelessWidget {
  const ColorSlidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
        child: Column(
          children: [
            const ColorSlider(
              channel: ColorChannel.red,
              label: 'R',
              color: Colors.red,
            ),
            const ColorSlider(
              channel: ColorChannel.green,
              label: 'G',
              color: Colors.green,
            ),
            const ColorSlider(
              channel: ColorChannel.blue,
              label: 'B',
              color: Colors.blue,
            ),
            const SizedBox(height: 4),
            OutlinedButton.icon(
              onPressed: () => context.read<ColorModel>().reset(),
              icon: const Icon(Icons.restart_alt),
              label: const Text('Скинути'),
            ),
          ],
        ),
      ),
    );
  }
}
