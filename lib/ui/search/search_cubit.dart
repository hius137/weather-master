import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_cubit/apis/api_service.dart';
import 'package:weather_cubit/model/entity/enum.dart';
import 'package:weather_cubit/model/entity/forecast.dart';
import 'package:weather_cubit/ui/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  void initData() async {
    final responseLocation = await requestLocation('Hanoi');
    if (responseLocation != null) {
      emit(state.copyWith(
        location: responseLocation,
      ));
    }
    final responseCurrent = await requestCurrent('Hanoi');
    final DateTime time = DateTime.parse(responseCurrent?.lastUpdated ?? '');
    final String timeCity = DateFormat.Hm().format(time);
    if (responseCurrent != null) {
      emit(state.copyWith(
        current: responseCurrent,
        timeCity: timeCity,
      ));
    }
    final responseCondition = await requestCondition('Hanoi');
    if (responseCondition != null) {
      emit(state.copyWith(
        condition: responseCondition,
      ));
    }
    final List<Forecastday>? listForecastday =
        await requestForecastday('Hanoi');
    if (responseCondition != null) {
      emit(state.copyWith(
        listForecastday: listForecastday,
      ));
    }
  }

  Future<void> searchByCity(String text) async {
    emit(state.copyWith(
      isSearch: false,
      getDataStatus: LoadStatus.loading,
    ));
    try {
      final responseLocation = await requestLocation(text);
      if (responseLocation != null) {
        emit(state.copyWith(
          location: responseLocation,
        ));
      }
      final responseCurrent = await requestCurrent(text);
      final DateTime time = DateTime.parse(responseCurrent?.lastUpdated ?? '');
      final String timeCity = DateFormat.Hm().format(time);
      if (responseCurrent != null) {
        emit(state.copyWith(
          current: responseCurrent,
          timeCity: timeCity,
        ));
      }
      final responseCondition = await requestCondition(text);
      if (responseCondition != null) {
        emit(state.copyWith(
          condition: responseCondition,
        ));
      }
      final List<Forecastday>? listForecastday = await requestForecastday(text);
      if (responseCondition != null) {
        emit(state.copyWith(
          listForecastday: listForecastday,
          getDataStatus: LoadStatus.success,
        ));
      }
    } catch (e) {
      print('error >>> $e');
      emit(state.copyWith(
        getDataStatus: LoadStatus.fail,
      ));
    }
  }
}
