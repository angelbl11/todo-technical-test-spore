import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        controller: controller,
        hintText: 'Buscar tareas...',
        leading: const Icon(Icons.search),
        onChanged: onChanged,
      ),
    );
  }
}
