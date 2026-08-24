import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/features/todo/application/todos_state.dart';
import 'package:todo/features/todo/domain/todo.dart';

part 'todos_controller.g.dart';

@riverpod
class TodosController extends _$TodosController {
  @override
  TodosState build() {
    return TodosState.initial();
  }

  // custome method
  void addTodo(String title) {
    // check if title contain some empty spaces on left side and right side
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      return;
    }
    // create todo variable, new todo
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: trimmedTitle,
      isCompleted: false,
    );

    // we will grab the state of this controller, whenever we change the state it will affect the ui, the states
    // comes from the file we generated
    // we keep the formal todos and add new one
    state = state.copyWith(todos: [...state.todos, todo]);
  }

  // toggleTodo, it will be responsible for making our todos done or not done.
  void toggleTodo(String id) {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id != id) return todo;
      // else
      return todo.copyWith(isCompleted: !todo.isCompleted);
    }).toList();

    // grab out state again, and update it with our updated todos
    state = state.copyWith(todos: updatedTodos);
  }

  void deleteTodo(String id) {
    final updatedTodos = state.todos.where((todo) => todo.id != id).toList();
    state = state.copyWith(todos: updatedTodos);
  }

  void updateTodo(String id, String newTitle) {
    final trimmedTitle = newTitle.trim();
    if (trimmedTitle.isEmpty) {
      return;
    }
    // check if todo exist
    final todoExists = state.todos.any((todo) => todo.id == id);
    if (!todoExists) {
      // show error message to the user
      state = state.copyWith(errorMessage: "Could not update todo");
      return;
    }

    // if the id exist, update todo else return todo
    final updatedTodos = state.todos.map(
      (todo) => todo.id == id ? todo.copyWith(title: trimmedTitle) : todo,
    );

    // update the state
    state = state.copyWith(todos: updatedTodos.toList(), errorMessage: null);
  }
}
