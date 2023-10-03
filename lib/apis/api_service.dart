import 'package:dio/dio.dart';
import 'package:weather_cubit/model/entity/current.dart';
import 'package:weather_cubit/model/entity/forecast.dart';
import 'package:weather_cubit/model/entity/location.dart';
import 'package:weather_cubit/model/response/weather_response.dart';

Future<Location?> requestLocation(String city) async {
  final dio = Dio();
  try {
    final response = await dio.get(
        'http://api.weatherapi.com/v1/forecast.json?key=5ca9908ac0354adda3991154232709&q=$city');
    WeatherResponse data = WeatherResponse.fromJson(response.data);
    return data.location;
  } catch (e) {
    return null;
  }
}
Future<Current?> requestCurrent(String city) async {
  final dio = Dio();
  try {
    final response = await dio.get(
        'http://api.weatherapi.com/v1/forecast.json?key=5ca9908ac0354adda3991154232709&q=$city');
    WeatherResponse data = WeatherResponse.fromJson(response.data);
    return data.current;
  } catch (e) {
    return null;
  }
}
Future<Condition?> requestCondition(String city) async {
  final dio = Dio();
  try {
    final response = await dio.get(
        'http://api.weatherapi.com/v1/forecast.json?key=5ca9908ac0354adda3991154232709&q=$city');
    WeatherResponse data = WeatherResponse.fromJson(response.data);
    return data.current?.condition;
  } catch (e) {
    return null;
  }
}
Future<List<Forecastday>?> requestForecastday(String city) async {
  final dio = Dio();
  try {
    final response = await dio.get(
        'http://api.weatherapi.com/v1/forecast.json?key=5ca9908ac0354adda3991154232709&q=$city');
    WeatherResponse data = WeatherResponse.fromJson(response.data);
    return data.forecast?.forecastday;
  } catch (e) {
    return null;
  }
}
