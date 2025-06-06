import 'package:flutter/material.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/priority.dart';

class FilterBottomSheet extends StatefulWidget {
  final String sortBy;
  final Priority? priorityFilter;
  final bool? completionFilter;
  final Function(String) onSortByChanged;
  final Function(Priority?) onPriorityFilterChanged;
  final Function(bool?) onCompletionFilterChanged;

  const FilterBottomSheet({
    super.key,
    required this.sortBy,
    required this.priorityFilter,
    required this.completionFilter,
    required this.onSortByChanged,
    required this.onPriorityFilterChanged,
    required this.onCompletionFilterChanged,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _sortBy;
  late Priority? _priorityFilter;
  late bool? _completionFilter;

  @override
  void initState() {
    super.initState();
    _sortBy = widget.sortBy;
    _priorityFilter = widget.priorityFilter;
    _completionFilter = widget.completionFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filtrar y ordenar',
            style: AppTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Text(
            'Ordenar por',
            style: AppTheme.titleMedium,
          ),
          DropdownButton<String>(
            value: _sortBy,
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                value: 'dueDate',
                child: Text('Fecha de vencimiento'),
              ),
              DropdownMenuItem(
                value: 'priority',
                child: Text('Prioridad'),
              ),
              DropdownMenuItem(
                value: 'title',
                child: Text('Título'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _sortBy = value);
                widget.onSortByChanged(value);
              }
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Filtrar por prioridad',
            style: AppTheme.titleMedium,
          ),
          DropdownButton<Priority?>(
            value: _priorityFilter,
            isExpanded: true,
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Todas'),
              ),
              ...Priority.values.map(
                (priority) => DropdownMenuItem(
                  value: priority,
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: priority.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(priority.label),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() => _priorityFilter = value);
              widget.onPriorityFilterChanged(value);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Filtrar por estado',
            style: AppTheme.titleMedium,
          ),
          DropdownButton<bool?>(
            value: _completionFilter,
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                value: null,
                child: Text('Todos'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Pendientes'),
              ),
              DropdownMenuItem(
                value: true,
                child: Text('Completados'),
              ),
            ],
            onChanged: (value) {
              setState(() => _completionFilter = value);
              widget.onCompletionFilterChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
