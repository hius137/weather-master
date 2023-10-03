import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/model/entity/enum.dart';
import 'package:weather_cubit/ui/search/search_cubit.dart';
import 'package:weather_cubit/ui/search/search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: const SearchPageBody(),
    );
  }
}

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({super.key});

  @override
  State<SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  final controler = TextEditingController();
  late SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Center(
          child: Text(
            'Search',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocListener<SearchCubit, SearchState>(
        listenWhen: (prev, current) {
          return prev.listForecastday != current.listForecastday || prev.getDataStatus != current.getDataStatus;
        },
        listener: (context, state) {
          if (state.getDataStatus == LoadStatus.success) {
          Navigator.of(context).pop({
            'isSearch': true,
            'location': state.location,
            'current': state.current,
            'condition': state.condition,
            'listForecastday': state.listForecastday,
          });
          }
        },
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 450,
                  height: 100,
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: controler,
                    decoration: const InputDecoration(
                      labelText: 'City',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _searchCubit.searchByCity(controler.text);
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
