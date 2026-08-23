import 'package:flutter/material.dart';

class TodoAddingDialog extends StatefulWidget {
  const TodoAddingDialog({super.key});

  @override
  State<TodoAddingDialog> createState() => _TodoAddingDialogState();
}

class _TodoAddingDialogState extends State<TodoAddingDialog> {
  final textController = TextEditingController();
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
            Text('New Todo', style: textTheme.titleLarge),
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
                    if (title.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a title')),
                      );
                      return;
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
