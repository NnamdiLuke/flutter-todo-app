import 'package:flutter/material.dart';
import 'package:todo/features/todo/presentation/widgets/overview_card.dart';
import 'package:todo/features/todo/presentation/widgets/todo_adding_dialog.dart';
import 'package:todo/features/todo/presentation/widgets/todo_tile.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Overview card
            OverviewCard(),
            SizedBox(height: 12),
            // Todo task list
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return TodoTile();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TodoAddingDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
