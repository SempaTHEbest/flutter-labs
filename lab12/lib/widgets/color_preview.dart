import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_model.dart';

/// Preview-контейнер: перебудовується при кожній зміні моделі.
class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorModel>(
      builder: (context, model, child) {
        final textColor = model.isDark ? Colors.white : Colors.black87;

        return Container(
          width: 220,
          height: 220,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: model.color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: model.color.withValues(alpha: 0.5),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                model.hex,
                style: TextStyle(
                  color: textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'rgb(${model.red}, ${model.green}, ${model.blue})',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
