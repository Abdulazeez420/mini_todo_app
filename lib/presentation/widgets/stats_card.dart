import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final double width;
  final VoidCallback? onTap;

  const StatsCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = width > 600 ? (width / 3) - 24 : (width / 2) - 24;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '$count',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
