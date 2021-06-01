import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/src/themes/uber_map.dart';

part 'map_state.dart';
part 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _googleMapController;

  Polyline _myRoute = new Polyline(
    polylineId: PolylineId('my_route'),
    width: 4,
  );

  void initMap(GoogleMapController controller) {
    if (!state.mapReady) {
      this._googleMapController = controller;
      this._googleMapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapLoaded());
    }
  }

  void moveCamera(LatLng latLng) {
    final cameraUpdate = CameraUpdate.newLatLng(latLng);
    this._googleMapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapLoaded) yield state.copyWith(mapReady: true);
    if (event is OnLatLngUpdated) {
      List<LatLng> points = [...this._myRoute.points, event.latLng];
      this._myRoute = this._myRoute.copyWith(pointsParam: points);

      final currentPolylines = state.polylines;
      currentPolylines['my_route'] = this._myRoute;

      yield state.copyWith(polylines: currentPolylines);
    }
  }
}
