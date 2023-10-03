import 'package:equatable/equatable.dart';
import 'package:weather_cubit/model/entity/current.dart';
import 'package:weather_cubit/model/entity/enum.dart';
import 'package:weather_cubit/model/entity/forecast.dart';
import 'package:weather_cubit/model/entity/location.dart';

class HomeState extends Equatable {
  final Location? location;
  final Current? current;
  final Condition? condition;
  final String? timeCity;
  final List<Forecastday>? listForecastday;
  final LoadStatus getDataStatus;
  final bool isSwitched;

  @override
  List<Object?> get props => [
    location,
    current,
    condition,
    timeCity,
    listForecastday,
    getDataStatus,
    isSwitched
  ];

  const HomeState({
    this.location,
    this.current,
    this.condition,
    this.timeCity,
    this.listForecastday,
    this.getDataStatus = LoadStatus.init,
    this.isSwitched = false,
  });

  HomeState copyWith({
    Location? location,
    Current? current,
    Condition? condition,
    String? timeCity,
    List<Forecastday>? listForecastday,
    bool? isHome,
    LoadStatus? getDataStatus,
    bool? isSwitched
  }) {
    return HomeState(
      location: location ?? this.location,
      current: current ?? this.current,
      condition: condition ?? this.condition,
      timeCity: timeCity ?? this.timeCity,
      listForecastday: listForecastday ?? this.listForecastday,
      getDataStatus: getDataStatus ?? this.getDataStatus,
      isSwitched: isSwitched ?? this.isSwitched,
    );
  }
}