import 'dart:async';

import 'package:dio/dio.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/src/models/coords_info_response.dart';

import 'package:maps_app/src/models/route_response.dart';
import 'package:maps_app/src/models/places_response.dart';

import 'package:maps_app/src/helpers/helpers.dart';

import 'package:maps_app/src/environment/environment_dev.dart';

final _url = 'https://api.mapbox.com';

class TrafficService {
  final _directions = '$_url/directions/v5';
  final _geocoding = '$_url/geocoding/v5';

  final _dio = new Dio();
  static final _instace = TrafficService._();

  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 1000));

  final StreamController<PlacesResponse> _suggestionsController =
      new StreamController.broadcast();

  TrafficService._();

  factory TrafficService() {
    return _instace;
  }

  Stream<PlacesResponse> get suggestions => _suggestionsController.stream;

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
      return data;
    } catch (e) {
      print('Error: $e');
      return PlacesResponse(features: []);
    }
  }

  void getSuggestions(String query, LatLng proximity) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await getPlaces(value, proximity);
      this._suggestionsController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  Future<CoordsInfoResponse> getCoordsInfo(LatLng coords) async {
    try {
      final url =
          '$_geocoding/mapbox.places/${coords.longitude},${coords.latitude}.json';
      final response = await _dio.get(url, queryParameters: {
        'language': 'es',
        'access_token': environment['mapbox_token'],
      });

      final data = coordsInfoResponseFromJson(response.data);

      return data;
    } catch (e) {
      print('Error: $e');
      return CoordsInfoResponse(features: []);
    }
  }
}
