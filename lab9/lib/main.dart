import 'package:flutter/material.dart';

import 'theme.dart';
import 'widgets/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 9 - Ivanashko D.V.',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const SignInScreen(),
    );
  }
}
