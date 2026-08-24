import 'package:flutter/material.dart';

typedef UpdateTodoCallBack = void Function(String);

class UpdateTodoDialog extends StatefulWidget {
  final String title;
  final UpdateTodoCallBack onUpdateTodo;
  const UpdateTodoDialog({
    super.key,
    required this.title,
    required this.onUpdateTodo,
  });

  @override
  State<UpdateTodoDialog> createState() => _UpdateTodoDialogState();
}

class _UpdateTodoDialogState extends State<UpdateTodoDialog> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // on load set the textcontroller to title that will be pass
    textController.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // title
            Text('Update Todo', style: textTheme.titleLarge),
            SizedBox(height: 20),
            TextField(
              controller: textController,
              decoration: InputDecoration(hintText: 'Enter Todo title'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final title = textController.text;
                    if (title.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a title')),
                      );
                      return;
                    }
                    widget.onUpdateTodo(title);
                    Navigator.of(context).pop();
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
