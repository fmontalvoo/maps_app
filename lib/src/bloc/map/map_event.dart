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

class OnCreateRoute extends MapEvent {
  final double duration;
  final double distance;
  final List<LatLng> route;
  final String destinyName;

  OnCreateRoute(this.duration, this.distance, this.route, this.destinyName);
}
