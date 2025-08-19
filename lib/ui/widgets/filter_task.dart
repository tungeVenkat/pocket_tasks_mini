import 'package:flutter/material.dart';

class FilterTask extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterTask({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isSelected,
      onSelected: (_) {},
      selectedColor: Colors.deepPurpleAccent,
      backgroundColor: Colors.white.withOpacity(0.1),
    );
  }
}
