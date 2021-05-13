import 'package:flutter/material.dart';

import 'package:maps_app/src/pages/map_page.dart';
import 'package:maps_app/src/pages/loading_page.dart';
import 'package:maps_app/src/pages/gps_access_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoadingPage(),
      routes: {
        'map': (_) => MapPage(),
        'loading': (_) => LoadingPage(),
        'gps_access': (_) => GPSAccessPage(),
      },
    );
  }
}
