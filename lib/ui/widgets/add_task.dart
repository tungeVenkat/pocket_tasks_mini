import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class AddTaskWidget extends StatefulWidget {
  final Function(String) onAdd;

  const AddTaskWidget({super.key, required this.onAdd});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _handleAdd() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() {
        _errorText = "Task title cannot be empty";
      });
      return;
    }

    widget.onAdd(text);
    _controller.clear();
    setState(() {
      _errorText = null; // clear error after successful add
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.deepPurple,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Field
                Expanded(
                  child: Container(
                    height: 48, // Fixed height to match button
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.deepPurple.withOpacity(0.4),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: AppColors.white),
                      decoration: InputDecoration(
                        hintText: "Add Task",
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        errorText: null, // We'll show error outside
                        errorStyle: TextStyle(height: 0.8),
                      ),
                      onSubmitted: (_) => _handleAdd(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Add Button with consistent height
                SizedBox(
                  height: 48, // Same height as text field
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      elevation: 2,
                    ),
                    onPressed: _handleAdd,
                    child: const Text(
                      "ADD",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Error message with proper spacing
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4.0),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red[300],
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  _errorText!,
                  style: TextStyle(
                    color: Colors.red[300],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}