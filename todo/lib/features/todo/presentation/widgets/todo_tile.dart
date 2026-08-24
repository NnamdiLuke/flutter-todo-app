import 'package:flutter/material.dart';
import 'package:todo/features/todo/domain/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todos;
  final VoidCallback onToggleTodo;
  final VoidCallback onDeleteTodo;
  final VoidCallback onUpdateTodo;
  const TodoTile({
    super.key,
    required this.todos,
    required this.onToggleTodo,
    required this.onDeleteTodo,
    required this.onUpdateTodo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Checkbox(
              shape: CircleBorder(),
              value: todos.isCompleted,
              onChanged: (_) => onToggleTodo(),
            ),
            Expanded(
              child: Text(
                todos.title,
                style: textTheme.titleMedium?.copyWith(
                  decoration: todos.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            IconButton(onPressed: onUpdateTodo, icon: Icon(Icons.edit)),
            IconButton(
              onPressed: onDeleteTodo,
              icon: Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
