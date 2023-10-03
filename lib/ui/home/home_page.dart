import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/ui/home/home_cubit.dart';
import 'package:weather_cubit/ui/home/home_state.dart';
import 'package:weather_cubit/ui/search/search_page.dart';
import 'package:weather_cubit/ui/setting/setting_cubit.dart';
import 'package:weather_cubit/ui/setting/setting_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<SettingCubit>(
          create: (context) => SettingCubit(),
        ),
      ],
      child: const HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Flutter Weather',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (prev, current) { return prev.isSwitched != current.isSwitched;},
          builder: (context, state) {
            return IconButton(
              onPressed: () async {
                final res = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SettingPage(isSwitched: state.isSwitched),
                  ),
                );
                if (res == true) {
                  _homeCubit.changeTemp(res);
                }
              },
              icon: const Icon(Icons.settings),
            );
          }),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () async {
              final res = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
              _homeCubit.getData(res['location'], res['current'],
                  res['condition'], res['listForecastday']);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF27347c), Color(0xFF727ec2)],
          ),
        ),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.location?.name != null)
                  Text(
                    state.location?.name ?? '',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                if (state.timeCity != null)
                  Text(
                    'Update: ${state.timeCity ?? ''} AM',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFFEFEFEF),
                    ),
                  ),
                const SizedBox(height: 30),
                state.isSwitched ? _doF(state) : _doC(state),
                const SizedBox(height: 30),
                if (state.condition?.text != null)
                  Text(
                    state.condition?.text ?? '',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white70,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _doC(state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (state.condition?.icon != null)
          Image(image: NetworkImage('${state.condition?.icon ?? ''}')),
        if (state.current?.tempC != null)
          Text(
            '${state.current?.tempC ?? ''}°',
            style: const TextStyle(
              fontSize: 35,
              color: Colors.white70,
            ),
          ),
        Column(
          children: [
            if (state.listForecastday?[0].day?.maxtempC != null)
              Text(
                'max: ${state.listForecastday?[0].day?.maxtempC ?? ''}°',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
            if (state.listForecastday?[0].day?.mintempC != null)
              Text(
                'min: ${state.listForecastday?[0].day?.mintempC ?? ''}°',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              )
          ],
        )
      ],
    );
  }

  Widget _doF(state) {
    return Row(
      children: [
        if (state.condition?.icon != null)
          Image(image: NetworkImage('${state.condition?.icon ?? ''}')),
        if (state.current?.tempF != null)
          Text(
            '${state.current?.tempF ?? ''}°',
            style: const TextStyle(
              fontSize: 35,
              color: Colors.white70,
            ),
          ),
        Column(
          children: [
            if (state.listForecastday?[0].day?.mintempF != null)
              Text(
                'max: ${state.listForecastday?[0].day?.maxtempF ?? ''}°',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
            if (state.listForecastday?[0].day?.mintempF != null)
              Text(
                'min: ${state.listForecastday?[0].day?.mintempF ?? ''}°',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              )
          ],
        )
      ],
    );
  }
}
