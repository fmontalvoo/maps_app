part of 'ubication_bloc.dart';

@immutable
class UbicationState {
  final bool tracing;
  final bool existLastUbication;
  final LatLng latLng;

  UbicationState(
      {this.tracing = true, this.existLastUbication = false, this.latLng});

  UbicationState copyWith({
    bool tracing,
    bool existLastUbication,
    LatLng latLng,
  }) =>
      new UbicationState(
        tracing: tracing ?? this.tracing,
        existLastUbication: existLastUbication ?? this.existLastUbication,
        latLng: latLng ?? this.latLng,
      );
}
