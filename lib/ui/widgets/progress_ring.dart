import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final int completed;
  final int total;

  const ProgressRing({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final double progress =
        total == 0 ? 0.0 : (completed / total).clamp(0.0, 1.0);

    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 5,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.greenAccent,
            ),
          ),
          Text(
            "$completed/$total",
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
