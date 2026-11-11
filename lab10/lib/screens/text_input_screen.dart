import 'package:flutter/material.dart';

import 'preview_screen.dart';
import 'robot_dialog.dart';

class TextInputScreen extends StatefulWidget {
  const TextInputScreen({super.key});

  @override
  State<TextInputScreen> createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final _textController = TextEditingController();
  double _fontSize = 20;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _openPreview() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          text: _textController.text,
          fontSize: _fontSize,
        ),
      ),
    );

    if (!mounted) return;
    showResultDialog(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Text previewer'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text',
                  helperText: 'Enter some text',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('Font size: ${_fontSize.round()}'),
                  Expanded(
                    child: Slider(
                      value: _fontSize,
                      min: 10,
                      max: 60,
                      onChanged: (value) => setState(() => _fontSize = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _openPreview,
                child: const Text('Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
