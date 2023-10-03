import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/ui/setting/setting_cubit.dart';
import 'package:weather_cubit/ui/setting/setting_state.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
    this.isSwitched = false,
  });

  final bool isSwitched;

  @override
  Widget build(BuildContext context) {
    return SettingPageBody(isSwitched: isSwitched);
  }
}

class SettingPageBody extends StatefulWidget {
  const SettingPageBody({
    super.key,
    this.isSwitched = false,
  });

  final bool isSwitched;

  @override
  State<SettingPageBody> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPageBody> {
  late SettingCubit _settingCubit;

  @override
  void initState() {
    super.initState();
    _settingCubit = BlocProvider.of<SettingCubit>(context);
    _settingCubit.initData(widget.isSwitched);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            title:  const Center(
              child: Text(
                'Setting',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(state.isSwitched,
                );
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Temperature Units',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Use metric measurements for temperature units.')
                      ],
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: state.isSwitched,
                    onChanged: (value) {
                      _settingCubit.changeTemp(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
