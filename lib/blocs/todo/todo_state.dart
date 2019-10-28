import 'package:equatable/equatable.dart';
import 'package:hello_bloc/models/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {
  const TodoLoading();
  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  final Todo todo;
  const TodoLoaded(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);
  @override
  List<Object> get props => [message];
}