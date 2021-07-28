part of 'helpers.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  return await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(
      devicePixelRatio: 2.5,
    ),
    'assets/marker.png',
  );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final url =
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png';
  final response = await Dio().get(
    url,
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );

  final bytes = response.data;

  final imageCodec = await instantiateImageCodec(
    bytes,
    targetHeight: 150,
    targetWidth: 150,
  );
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ImageByteFormat.png);

  return await BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}
