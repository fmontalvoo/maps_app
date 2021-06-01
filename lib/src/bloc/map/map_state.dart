part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool drawPath;
  final bool followLocation;

  final LatLng mapCenter;
  final Map<String, Polyline> polylines;

  MapState({
    this.mapReady = false,
    this.drawPath = true,
    this.followLocation = false,
    this.mapCenter,
    Map<String, Polyline> polylines,
  }) : this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool mapReady,
    bool drawPath,
    bool followLocation,
    LatLng mapCenter,
    Map<String, Polyline> polylines,
  }) =>
      new MapState(
        mapReady: mapReady ?? this.mapReady,
        drawPath: drawPath ?? this.drawPath,
        followLocation: followLocation ?? this.followLocation,
        mapCenter: mapCenter ?? this.mapCenter,
        polylines: polylines ?? this.polylines,
      );
}
