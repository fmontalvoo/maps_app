part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool drawPath;
  final bool followLocation;

  final LatLng mapCenter;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapState({
    this.mapReady = false,
    this.drawPath = true,
    this.followLocation = false,
    this.mapCenter,
    Map<String, Marker> markers,
    Map<String, Polyline> polylines,
  })  : this.markers = markers ?? new Map(),
        this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool mapReady,
    bool drawPath,
    LatLng mapCenter,
    bool followLocation,
    Map<String, Marker> markers,
    Map<String, Polyline> polylines,
  }) =>
      new MapState(
        mapReady: mapReady ?? this.mapReady,
        drawPath: drawPath ?? this.drawPath,
        mapCenter: mapCenter ?? this.mapCenter,
        followLocation: followLocation ?? this.followLocation,
        markers: markers ?? this.markers,
        polylines: polylines ?? this.polylines,
      );
}
