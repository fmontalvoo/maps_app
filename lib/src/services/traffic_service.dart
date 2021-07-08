import 'package:dio/dio.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:maps_app/src/models/route_response.dart';
import 'package:maps_app/src/models/places_response.dart';

import 'package:maps_app/src/environment/environment_dev.dart';

final _url = 'https://api.mapbox.com';

class TrafficService {
  final _directions = '$_url/directions/v5';
  final _geocoding = '$_url/geocoding/v5';

  static final _instace = TrafficService._();
  final _dio = new Dio();

  TrafficService._();

  factory TrafficService() {
    return _instace;
  }

  Future<RouteResponse> getCoordsRoute(LatLng start, LatLng end) async {
    final cords =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_directions/mapbox/driving/$cords';

    final response = await _dio.get(url, queryParameters: {
      'steps': false,
      'language': 'es',
      'alternatives': true,
      'geometries': 'polyline6',
      'access_token': environment['mapbox_token']
    });

    final data = RouteResponse.fromJson(response.data);

    return data;
  }

  Future<PlacesResponse> getPlaces(String query, LatLng proximity) async {
    try {
      final url = '$_geocoding/mapbox.places/$query.json';
      final response = await _dio.get(url, queryParameters: {
        'language': 'es',
        'autocomplete': true,
        'access_token': environment['mapbox_token'],
        'proximity': '${proximity.longitude},${proximity.latitude}',
      });

      final data = placesResponseFromJson(response.data);
      print(data);
      return data;
    } catch (e) {
      print('Error: $e');
      return PlacesResponse(features: []);
    }
  }
}
