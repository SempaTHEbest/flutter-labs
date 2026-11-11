import 'package:flutter/material.dart';

import 'widgets/container_configurator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 - Ivanashko D.V.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Іванашко Д.В., Лаб. 7'),
          backgroundColor: Colors.red.shade100,
        ),
        body: const ContainerConfigurator(),
      ),
    );
  }
}
