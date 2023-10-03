import 'package:bloc/bloc.dart';
import 'package:weather_cubit/ui/setting/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(const SettingState());

  void initData(bool isSwitched) {
    emit(state.copyWith(isSwitched: isSwitched));
  }

  void changeTemp(bool value) {
    emit(state.copyWith(isSwitched: value));
  }
}
