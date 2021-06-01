part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool drawPath;
  final bool followLocation;

  final Map<String, Polyline> polylines;

  MapState({
    this.mapReady = false,
    this.drawPath = true,
    this.followLocation = false,
    Map<String, Polyline> polylines,
  }) : this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool mapReady,
    bool drawPath,
    bool followLocation,
    Map<String, Polyline> polylines,
  }) =>
      new MapState(
        mapReady: mapReady ?? this.mapReady,
        drawPath: drawPath ?? this.drawPath,
        followLocation: followLocation ?? this.followLocation,
        polylines: polylines ?? this.polylines,
      );
}
