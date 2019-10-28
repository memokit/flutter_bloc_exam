import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Todo extends Equatable {
  final String name;
  final String detail;

  Todo({
    @required this.name,
    @required this.detail,
  });

  @override
  List<Object> get props => [name, detail];
}
