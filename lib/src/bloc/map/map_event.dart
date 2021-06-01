part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapLoaded extends MapEvent {}

class OnLatLngUpdated extends MapEvent {
  final LatLng latLng;

  OnLatLngUpdated(this.latLng);
}

class OnDrawPath extends MapEvent {}
