part of 'widgets.dart';

Future<BitmapDescriptor> getStartMarkerIcon(int duration) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(350, 150);

  final minutos = (duration / 60).floor();

  final markerStart = MarkerStart(minutos);
  markerStart.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}

Future<BitmapDescriptor> getDestinyMarkerIcon(
    String destinyName, double distance) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(350, 150);

  final markerEnd = MarkerEnd(destinyName, distance);
  markerEnd.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}
