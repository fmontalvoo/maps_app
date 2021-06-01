part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapLoaded extends MapEvent {}

class OnLatLngUpdated extends MapEvent {
  final LatLng latLng;

  OnLatLngUpdated(this.latLng);
}

class OnMapMove extends MapEvent {
  final LatLng mapCenter;

  OnMapMove(this.mapCenter);
}

class OnDrawPath extends MapEvent {}

class OnFollowLocation extends MapEvent {}
