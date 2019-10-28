import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hello_bloc/data/todo_repository.dart';
import './todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository);

  @override
  TodoState get initialState => TodoInitial();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    // Emitting a state from the asynchronous generator
    yield TodoLoading();
    // Branching the executed logic by checking the event type
    if (event is GetTodo) {
      // Emit either Loaded or Error
      try {
        final weather = await repository.fetchTodo();
        yield TodoLoaded(weather);
      } on NetworkError {
        yield TodoError("Couldn't fetch todo. Is the device online?");
      }
    } else if (event is GetDetailedTodo) {
      // Code duplication 😢 to keep the code simple for the tutorial...
      try {
        final weather = await repository.fetchDetailedTodo(event.name);
        yield TodoLoaded(weather);
      } on NetworkError {
        yield TodoError("Couldn't fetch todo. Is the device online?");
      }
    }
  }
}
