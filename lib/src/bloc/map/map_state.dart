part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool drawPath;

  final Map<String, Polyline> polylines;

  MapState({
    this.mapReady = false,
    this.drawPath = true,
    Map<String, Polyline> polylines,
  }) : this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool mapReady,
    bool drawPath,
    Map<String, Polyline> polylines,
  }) =>
      new MapState(
        mapReady: mapReady ?? this.mapReady,
        drawPath: drawPath ?? this.drawPath,
        polylines: polylines ?? this.polylines,
      );
}
