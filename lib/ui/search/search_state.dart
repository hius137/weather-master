import 'package:equatable/equatable.dart';
import 'package:weather_cubit/model/entity/current.dart';
import 'package:weather_cubit/model/entity/enum.dart';
import 'package:weather_cubit/model/entity/forecast.dart';
import 'package:weather_cubit/model/entity/location.dart';
import 'package:weather_cubit/model/response/weather_response.dart';

class SearchState extends Equatable {
  final Location? location;
  final Current? current;
  final Condition? condition;
  final String? timeCity;
  final List<Forecastday>? listForecastday;
  final bool isSearch;
  final WeatherResponse? weatherResponse;

  final LoadStatus getDataStatus;

  @override
  List<Object?> get props => [
        location,
        current,
        condition,
        timeCity,
        listForecastday,
        isSearch,
        getDataStatus,
    weatherResponse,
      ];

  const SearchState({
    this.location,
    this.current,
    this.condition,
    this.timeCity,
    this.listForecastday,
    this.isSearch = false,
    this.weatherResponse,
    this.getDataStatus = LoadStatus.init,
  });

  SearchState copyWith({
    Location? location,
    Current? current,
    Condition? condition,
    String? timeCity,
    List<Forecastday>? listForecastday,
    bool? isSearch,
    WeatherResponse? weatherResponse,
    LoadStatus? getDataStatus,
  }) {
    return SearchState(
      location: location ?? this.location,
      current: current ?? this.current,
      condition: condition ?? this.condition,
      timeCity: timeCity ?? this.timeCity,
      listForecastday: listForecastday ?? this.listForecastday,
      isSearch: isSearch ?? this.isSearch,
      weatherResponse: weatherResponse ?? this.weatherResponse,
      getDataStatus: getDataStatus ?? this.getDataStatus,
    );
  }
}
