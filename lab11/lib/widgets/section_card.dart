import 'package:flutter/material.dart';

/// Картка з заголовком; поки даних немає - показує індикатор або підказку.
class SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool loading;
  final String? error;
  final Widget? child;

  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.loading,
    this.error,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Widget body;
    if (error != null) {
      body = Row(
        children: [
          Icon(Icons.error_outline, color: colors.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(error!, style: TextStyle(color: colors.error)),
          ),
        ],
      );
    } else if (child != null) {
      body = child!;
    } else if (loading) {
      body = const Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text('Завантаження...'),
        ],
      );
    } else {
      body = Text('Немає даних', style: TextStyle(color: colors.outline));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: colors.primary),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            body,
          ],
        ),
      ),
    );
  }
}
