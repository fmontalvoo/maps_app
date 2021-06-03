import 'package:meta/meta.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ResultSearch {
  final bool canceled;
  final bool manual;
  final LatLng latLng;
  final String destinyName;
  final String description;

  ResultSearch({
    @required this.canceled,
    this.manual,
    this.latLng,
    this.destinyName,
    this.description,
  });
}
