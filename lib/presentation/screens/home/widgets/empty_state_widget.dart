import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool hasFilters;

  const EmptyStateWidget({
    super.key,
    required this.hasFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        hasFilters
            ? 'No hay tareas que coincidan con los filtros'
            : 'No hay tareas',
      ),
    );
  }
}
