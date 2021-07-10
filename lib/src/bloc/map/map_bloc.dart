import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:flutter/material.dart' show Colors;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/src/themes/uber_map.dart';

part 'map_state.dart';
part 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _googleMapController;

  Polyline _myRoute = new Polyline(
    width: 4,
    color: Colors.black87,
    polylineId: PolylineId('my_route'),
  );

  Polyline _driveRoute = new Polyline(
    width: 4,
    color: Colors.black87,
    polylineId: PolylineId('drive_route'),
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
    if (event is OnLatLngUpdated) yield* _onLatLngUpdated(event);
    if (event is OnDrawPath) yield* _onDrawPath(event);
    if (event is OnFollowLocation) yield* _onFollowLocation(event);
    if (event is OnMapMove) yield state.copyWith(mapCenter: event.mapCenter);
    if (event is OnCreateRoute) yield* _onCreateRoute(event);
  }

  Stream<MapState> _onLatLngUpdated(OnLatLngUpdated event) async* {
    if (state.followLocation) moveCamera(event.latLng);

    final points = [...this._myRoute.points, event.latLng];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _onDrawPath(OnDrawPath event) async* {
    if (!state.drawPath)
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.black87);
    else
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;

    yield state.copyWith(
        drawPath: !state.drawPath, polylines: currentPolylines);
  }

  Stream<MapState> _onFollowLocation(OnFollowLocation event) async* {
    if (!state.followLocation) moveCamera(this._myRoute.points.last);
    yield state.copyWith(followLocation: !state.followLocation);
  }

  Stream<MapState> _onCreateRoute(OnCreateRoute event) async* {
    this._driveRoute = this._driveRoute.copyWith(
          pointsParam: event.route,
        );

    final polylines = state.polylines;
    polylines['drive_route'] = this._driveRoute;

    final startMarker = new Marker(
      markerId: MarkerId('start'),
      position: event.route.first,
    );

    final endMarker = new Marker(
      markerId: MarkerId('end'),
      position: event.route.last,
    );

    final markers = {...state.markers};

    markers['start'] = startMarker;
    markers['end'] = endMarker;

    yield state.copyWith(
      polylines: polylines,
      markers: markers,
    );
  }
}
