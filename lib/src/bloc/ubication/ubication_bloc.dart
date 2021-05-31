import 'dart:async';

import 'package:meta/meta.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:flutter_bloc/flutter_bloc.dart';

part 'ubication_state.dart';
part 'ubication_event.dart';

class UbcationBloc extends Bloc<UbicationEvent, UbicationState> {
  StreamSubscription<Position> _positionSubscription;

  UbcationBloc() : super(UbicationState());

  void initTracing() {
    _positionSubscription = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
        .listen((Position position) {
      print(position);
    });
  }

  void stopTracing() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<UbicationState> mapEventToState(UbicationEvent event) async* {}
}
