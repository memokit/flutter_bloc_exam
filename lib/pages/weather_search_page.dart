import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_bloc/blocs/todo/todo.dart';
import 'package:hello_bloc/blocs/todo/todo_bloc.dart';
import 'package:hello_bloc/blocs/weather/weather.dart';
import 'package:hello_bloc/models/weather.dart';
import 'package:hello_bloc/pages/todo_page.dart';
import 'package:hello_bloc/pages/weather_detail_page.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: MultiBlocListener(
            listeners: [
              BlocListener<WeatherBloc, WeatherState>(
                listener: (context, state) {},
              ),
              BlocListener<TodoBloc, TodoState>(
                listener: (context, state) {},
              ),
            ],
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return buildInitialInput();
                } else if (state is WeatherLoading) {
                  return buildLoading();
                } else if (state is WeatherLoaded) {
                  return buildColumnWithData(context, state.weather);
                } else if (state is WeatherError) {
                  return buildInitialInput();
                }
              },
            ),
          )
          // child: BlocListener<WeatherBloc, WeatherState>(
          //   listener: (context, state) {
          //     if (state is WeatherError) {
          //       Scaffold.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text(state.message),
          //         ),
          //       );
          //     }
          //   },
          //   child: BlocBuilder<WeatherBloc, WeatherState>(
          //     builder: (context, state) {
          //       if (state is WeatherInitial) {
          //         return buildInitialInput();
          //       } else if (state is WeatherLoading) {
          //         return buildLoading();
          //       } else if (state is WeatherLoaded) {
          //         return buildColumnWithData(context, state.weather);
          //       } else if (state is WeatherError) {
          //         return buildInitialInput();
          //       }
          //     },
          //   ),
          // ),
          ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<WeatherBloc>(context),
                  child: WeatherDetailPage(
                    masterWeather: weather,
                  ),
                ),
              ),
            );
          },
        ),
        RaisedButton(
          child: Text('Todo'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<TodoBloc>(context),
                  child: TodoPage(),
                ),
              ),
            );
          },
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(cityName));
    // weatherBloc.close();
  }
}
