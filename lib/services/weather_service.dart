import 'package:dio/dio.dart';

import '../models/weather_model.dart';

class WeatherService{
  WeatherService(this.dio);
  final Dio dio;

  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = '96fd575132ae4c3295805907232612';

  Future<WeatherModel> getCurrentWeather({required String cityName}) async
  {

    try{

      Response response = await dio.get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;

    } on DioException catch(e){

      final String errorMesg = e.response?.data['error']['message'] ?? 'oops there was an error!, try later';
      throw Exception(errorMesg);

    }catch(e)
    {
      throw Exception('oops there was an error!, try later');
    }
  }
}