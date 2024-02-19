import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/weather_states.dart';

import '../../models/weather_model.dart';
import '../../services/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(InitialState());

  WeatherModel? weatherModel;

  getWeather({required String cityName}) async {
    try {
      emit(WeatherLoadingState());

      weatherModel =
          await WeatherService(Dio()).getCurrentWeather(cityName: cityName);

      emit(WeatherLoadedState());
    } catch (e) {
      emit(WeatherFailureState());
    }
  }

  MaterialColor getWeatherColor(String? condition) {

    if(condition == null ){
      return Colors.blue;
    }
    switch (condition.toLowerCase()) {
      case "sunny":
      case "clear":
        return Colors.yellow;
      case "partly cloudy":
        return Colors.lightBlue;
      case "cloudy":
      case "overcast":
        return Colors.grey;
      case "mist":
        return Colors.blueGrey;
      case "patchy rain possible":
      case "patchy snow possible":
      case "patchy sleet possible":
      case "patchy freezing drizzle possible":
      case "thundery outbreaks possible":
      case "blowing snow":
      case "blizzard":
      case "fog":
      case "freezing fog":
        return Colors.lightBlue; // You can assign a specific color for these conditions
      case "patchy light drizzle":
      case "light drizzle":
      case "freezing drizzle":
      case "heavy freezing drizzle":
      case "patchy light rain":
      case "light rain":
      case "moderate rain at times":
      case "moderate rain":
      case "heavy rain at times":
      case "heavy rain":
        return Colors.blue;
      case "light freezing rain":
      case "moderate or heavy freezing rain":
        return Colors.lightBlue;
      case "light sleet":
      case "moderate or heavy sleet":
        return Colors.indigo;
      case "patchy light snow":
      case "light snow":
      case "patchy moderate snow":
      case "moderate snow":
      case "patchy heavy snow":
      case "heavy snow":
      case "ice pellets":
      case "light rain shower":
      case "moderate or heavy rain shower":
      case "torrential rain shower":
      case "light sleet showers":
      case "moderate or heavy sleet showers":
      case "light snow showers":
      case "moderate or heavy snow showers":
        return Colors.blueGrey;
      case "light showers of ice pellets":
      case "moderate or heavy showers of ice pellets":
        return Colors.blue;
      case "patchy light rain with thunder":
      case "moderate or heavy rain with thunder":
      case "patchy light snow with thunder":
      case "moderate or heavy snow with thunder":
        return Colors.purple;

      default:
        return Colors.blue; // Default color for unknown weather conditions
    }
  }

}
