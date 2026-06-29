import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(title),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: const Color(0xFF8DD3F3),
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(
          color: selected ? Colors.black : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}