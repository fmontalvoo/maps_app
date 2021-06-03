import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/src/bloc/map/map_bloc.dart';
import 'package:maps_app/src/bloc/search/search_bloc.dart';
import 'package:maps_app/src/bloc/ubication/ubication_bloc.dart';

import 'package:maps_app/src/pages/map_page.dart';
import 'package:maps_app/src/pages/loading_page.dart';
import 'package:maps_app/src/pages/gps_access_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MapBloc()),
        BlocProvider(create: (_) => SearchBloc()),
        BlocProvider(create: (_) => UbcationBloc()),
      ],
      child: MaterialApp(
        title: 'Maps',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoadingPage(),
        routes: {
          'map': (_) => MapPage(),
          'loading': (_) => LoadingPage(),
          'gps_access': (_) => GPSAccessPage(),
        },
      ),
    );
  }
}
