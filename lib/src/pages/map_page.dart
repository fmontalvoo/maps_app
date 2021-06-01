import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/src/bloc/map/map_bloc.dart';
import 'package:maps_app/src/bloc/ubication/ubication_bloc.dart';

import 'package:maps_app/src/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    context.read<UbcationBloc>().initTracing();
    super.initState();
  }

  @override
  void dispose() {
    context.read<UbcationBloc>().stopTracing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UbcationBloc, UbicationState>(
        builder: (BuildContext context, state) => createMap(state),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          UbicationButton(),
        ],
      ),
    );
  }

  Widget createMap(UbicationState state) {
    if (!state.existLastUbication) return Center(child: Text("Localizando"));

    final mapBloc = context.watch<MapBloc>();

    final initialCameraPosition =
        CameraPosition(target: state.latLng, zoom: 14);

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: mapBloc.initMap,
    );
  }
}
