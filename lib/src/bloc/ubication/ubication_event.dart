part of 'ubication_bloc.dart';

@immutable
abstract class UbicationEvent {}

class OnUbicationChange extends UbicationEvent {
  final LatLng latLng;

  OnUbicationChange(this.latLng);
}
