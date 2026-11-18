import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/color_model.dart';
import 'widgets/color_preview.dart';
import 'widgets/color_sliders_section.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ColorModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 12 - Ivanashko D.V.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Іванашко Д.В., Лаб. 12'),
          backgroundColor: Colors.indigo.shade100,
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(child: Center(child: ColorPreview())),
                ColorSlidersSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
