import 'package:dio/dio.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/src/environtment/environment_dev.dart';
import 'package:maps_app/src/models/route_response.dart';

class TrafficService {
  final _url = 'https://api.mapbox.com/directions/v5';
  static final _instace = TrafficService._();
  final _dio = new Dio();

  TrafficService._();

  factory TrafficService() {
    return _instace;
  }

  Future<RouteResponse> getCoordsRoute(LatLng start, LatLng end) async {
    final cords =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_url/mapbox/driving/$cords';

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
}
