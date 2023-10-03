import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_cubit/model/entity/current.dart';
import 'package:weather_cubit/model/entity/forecast.dart';
import 'package:weather_cubit/model/entity/location.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void getData(Location location, Current current, Condition condition,
      List<Forecastday> forecastday) {
    final time = DateTime.parse(current.lastUpdated ?? '');
    String timeCity = DateFormat.Hm().format(time);
    emit(state.copyWith(
      location: location,
      timeCity: timeCity,
      condition: current.condition,
      current: current,
      listForecastday: forecastday,
    ));
  }

  void changeTemp(bool value){
    emit(state.copyWith(isSwitched: value));
  }
}
