import 'package:flutter/material.dart';

class FilterTask extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterTask({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // pill shape
        side: BorderSide(
            color: isSelected ? Colors.deepPurpleAccent : Colors.grey.shade300),
      ),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: Colors.deepPurpleAccent,
      backgroundColor: Colors.white.withOpacity(0.5),
    );
  }
}
