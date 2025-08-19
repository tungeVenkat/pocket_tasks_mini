import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final int completed;
  final int total;

  const ProgressRing({super.key, required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            value: completed / total,
            strokeWidth: 5,
            backgroundColor: Colors.grey.shade800,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        Text(
          "$completed/$total",
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}
