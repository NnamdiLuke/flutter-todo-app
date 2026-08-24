import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/todo/application/completed_todos_provider.dart';
import 'package:todo/features/todo/application/todos_controller.dart';
import 'package:todo/features/todo/presentation/widgets/overview_card.dart';
import 'package:todo/features/todo/presentation/widgets/todo_adding_dialog.dart';
import 'package:todo/features/todo/presentation/widgets/todo_tile.dart';
import 'package:todo/features/todo/presentation/widgets/update_todo_dialog.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // grab all of our controllers and state values
    final state = ref.watch(todosControllerProvider);
    final commpletedcount = ref.watch(completedTodosCountProvider);
    final todos = state.todos;
    final isLoading = state.isLoading;
    final errorMessage = state.errorMessage;
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage))
          : todos.isEmpty
          ? Center(child: Text('No todos yet.Add your first todo.'))
          : SafeArea(
              child: Column(
                children: [
                  // Overview card
                  OverviewCard(
                    commpletedcount: commpletedcount,
                    totalTodosCount: todos.length,
                  ),
                  SizedBox(height: 12),
                  // Todo task list
                  Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return TodoTile(
                          todos: todos[index],
                          onToggleTodo: () {
                            ref
                                .read(todosControllerProvider.notifier)
                                .toggleTodo(todos[index].id);
                          },
                          onDeleteTodo: () {
                            ref
                                .read(todosControllerProvider.notifier)
                                .deleteTodo(todos[index].id);
                          },
                          onUpdateTodo: () {
                            showDialog(
                              context: context,
                              builder: (context) => UpdateTodoDialog(
                                title: todos[index].title,
                                onUpdateTodo: (newTitle) {
                                  ref
                                      .read(todosControllerProvider.notifier)
                                      .updateTodo(todos[index].id, newTitle);
                                },
                              ),
                            );
                          },
                        );
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
            builder: (context) => TodoAddingDialog(
              onAddTodo: (title) {
                ref.read(todosControllerProvider.notifier).addTodo(title);
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
