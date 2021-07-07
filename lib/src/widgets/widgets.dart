import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline/polyline.dart' as line;

import 'package:maps_app/src/models/result_search.dart';

import 'package:maps_app/src/bloc/map/map_bloc.dart';
import 'package:maps_app/src/bloc/search/search_bloc.dart';
import 'package:maps_app/src/bloc/ubication/ubication_bloc.dart';

import 'package:maps_app/src/search/search_location.dart';
import 'package:maps_app/src/services/traffic_service.dart';

import 'package:maps_app/src/helpers/helpers.dart';

part 'search_bar.dart';
part 'route_button.dart';
part 'follow_button.dart';
part 'ubication_button.dart';
part 'marker_indicator.dart';
