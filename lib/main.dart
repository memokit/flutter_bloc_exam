import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_bloc/blocs/todo/todo_bloc.dart';
import 'package:hello_bloc/blocs/weather/weather_bloc.dart';
import 'package:hello_bloc/pages/weather_search_page.dart';

import 'data/todo_repository.dart';
import 'data/weather_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            builder: (BuildContext context) =>
                WeatherBloc(FakeWeatherRepository()),
          ),
          BlocProvider<TodoBloc>(
            builder: (BuildContext context) => TodoBloc(TodoImpRepository()),
          ),
        ],
        child: WeatherSearchPage(),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weather App',
//       home: BlocProvider(
//         builder: (context) => WeatherBloc(FakeWeatherRepository()),
//         child: WeatherSearchPage(),
//       ),
//     );
//   }
// }
