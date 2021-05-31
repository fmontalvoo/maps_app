import 'package:flutter/material.dart';

import 'package:maps_app/src/bloc/ubication/ubication_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    context.bloc<UbcationBloc>().initTracing();
    super.initState();
  }

  @override
  void dispose() {
    context.bloc<UbcationBloc>().stopTracing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Map Page')),
    );
  }
}
