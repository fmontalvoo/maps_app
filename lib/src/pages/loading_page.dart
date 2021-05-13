import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:maps_app/src/pages/map_page.dart';

import 'package:maps_app/src/helpers/helpers.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state ==
        AppLifecycleState
            .resumed) if (await Geolocator.isLocationServiceEnabled())
      Navigator.pushReplacement(context, fadeInNavigation(context, MapPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkGPS(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final gpsStatus = snapshot.data;
              return Center(child: Text(gpsStatus));
            }
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2.0),
            );
          }),
    );
  }

  Future checkGPS(BuildContext context) async {
    final gpsPermission = await Permission.location.isGranted;
    final isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (gpsPermission && isLocationServiceEnabled)
      Navigator.pushReplacement(context, fadeInNavigation(context, MapPage()));

    if (!gpsPermission) {
      return 'Povafor otorgue el permiso de acceso a la ubicación.';
    }

    if (!isLocationServiceEnabled) {
      return 'Povafor permita a la aplicación obtener acceso a su ubicación.';
    }
  }
}
