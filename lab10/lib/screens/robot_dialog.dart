import 'package:flutter/material.dart';

const String robotIconUrl =
    'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090';

/// true - натиснуто OK, false - Cancel, null - повернення без кнопок.
String resultMessage(bool? result) {
  switch (result) {
    case true:
      return 'Cool!';
    case false:
      return 'Let’s try something else';
    case null:
      return "Don't know what to say";
  }
}

void showResultDialog(BuildContext context, bool? result) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        icon: Image.network(
          robotIconUrl,
          width: 48,
          height: 48,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.smart_toy_outlined, size: 48),
        ),
        content: Text(resultMessage(result), textAlign: TextAlign.center),
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
