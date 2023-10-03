import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final bool isSwitched;

  @override
  List<Object?> get props => [
        isSwitched,
      ];

  const SettingState({
    this.isSwitched = false,
  });

  SettingState copyWith({
    bool? isSwitched,
  }) {
    return SettingState(
      isSwitched: isSwitched ?? this.isSwitched,
    );
  }
}
