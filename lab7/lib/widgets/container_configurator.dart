import 'package:flutter/material.dart';

import 'value_slider.dart';

class ContainerConfigurator extends StatefulWidget {
  const ContainerConfigurator({super.key});

  @override
  State<ContainerConfigurator> createState() => _ContainerConfiguratorState();
}

class _ContainerConfiguratorState extends State<ContainerConfigurator> {
  static const double _maxSize = 300;

  double _width = 200;
  double _height = 150;
  double _topRightRadius = 40;

  @override
  Widget build(BuildContext context) {
    final maxRadius = (_width < _height ? _width : _height) / 2;
    final radius = _topRightRadius > maxRadius ? maxRadius : _topRightRadius;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: _width,
                  height: _height,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radius),
                    ),
                  ),
                ),
              ),
            ),
            ValueSlider(
              label: 'Ширина',
              value: _width,
              min: 20,
              max: _maxSize,
              onChanged: (v) => setState(() => _width = v),
            ),
            ValueSlider(
              label: 'Висота',
              value: _height,
              min: 20,
              max: _maxSize,
              onChanged: (v) => setState(() => _height = v),
            ),
            ValueSlider(
              label: 'Радіус верхнього правого кута',
              value: radius,
              min: 0,
              max: maxRadius,
              onChanged: (v) => setState(() => _topRightRadius = v),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => setState(() {
                _width = 200;
                _height = 150;
                _topRightRadius = 40;
              }),
              icon: const Icon(Icons.restart_alt),
              label: const Text('Скинути'),
            ),
          ],
        ),
      ),
    );
  }
}
