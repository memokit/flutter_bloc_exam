import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class GetTodo extends TodoEvent {
  const GetTodo();

  @override
  List<Object> get props => [];
}

class GetDetailedTodo extends TodoEvent {
  final String name;

  const GetDetailedTodo(this.name);

  @override
  List<Object> get props => [name];
}