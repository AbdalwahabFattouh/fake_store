import 'package:flutter/material.dart';

class CustemSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const CustemSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        cursorColor: theme.primaryColor,
        onChanged: onSearch,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7)),
          hintText: "Search Products...",
          hintStyle: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.dividerColor),
          ),
          filled: true,
          fillColor: theme.cardColor.withOpacity(0.1),
        ),
        style: TextStyle(color: theme.textTheme.bodyMedium?.color),
      ),
    );
  }
}
