import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class GPSAccessPage extends StatefulWidget {
  @override
  _GPSAccessPageState createState() => _GPSAccessPageState();
}

class _GPSAccessPageState extends State<GPSAccessPage>
    with WidgetsBindingObserver {
  bool popup = false;

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
    if (state == AppLifecycleState.resumed && !popup) if (await Permission
        .location.isGranted) Navigator.pushReplacementNamed(context, 'loading');
    // super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Para usar esta aplicación es necesario activar la ubicación'),
            MaterialButton(
                color: Colors.black,
                shape: StadiumBorder(),
                splashColor: Colors.transparent,
                child: Text(
                  'Solicitar acceso',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  popup = true;
                  final status = await Permission.location.request();
                  await locationPermissions(status);
                  popup = false;
                }),
          ],
        ),
      ),
    );
  }

  Future locationPermissions(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, 'loading');
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.undetermined:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}
