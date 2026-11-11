import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Image.asset('assets/logo.png', width: size, height: size),
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const ScreenHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(title, style: textTheme.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Text(subtitle, style: textTheme.bodyMedium, textAlign: TextAlign.center),
      ],
    );
  }
}

void showMessage(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
