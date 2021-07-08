part of 'widgets.dart';

class MarkerIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state.manualSelection) return _MarkerIndicator();

      return SizedBox.shrink();
    });
  }
}

class _MarkerIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = context.watch<SearchBloc>();

    return Stack(
      children: [
        Positioned(
          top: 50.0,
          child: MaterialButton(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            shape: CircleBorder(),
            child: BackButtonIcon(),
            onPressed: () {
              searchBloc.add(OnDeactivateMarker());
            },
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -15),
            child: BounceInDown(
              from: 250.0,
              child: Icon(Icons.location_on, size: 32.0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 50.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FadeIn(
              child: MaterialButton(
                minWidth: size.width - 220,
                color: Colors.black,
                textColor: Colors.white,
                shape: StadiumBorder(),
                child: Text('Confirmar'),
                onPressed: () {
                  calculateRoute(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void calculateRoute(BuildContext context) async {
    displayMessage(context);
    final mapBloc = context.read<MapBloc>();
    final searchBloc = context.read<SearchBloc>();

    final trafficService = new TrafficService();
    final start = context.read<UbcationBloc>().state.latLng;
    final end = mapBloc.state.mapCenter;
    final route = await trafficService.getCoordsRoute(start, end);

    final geometry = route.routes.first.geometry;
    final duration = route.routes.first.duration;
    final distance = route.routes.first.distance;

    final points = line.Polyline.Decode(
      encodedString: geometry,
      precision: 6,
    ).decodedCoords;

    final coords = points
        .map(
          (point) => LatLng(point[0], point[1]),
        )
        .toList();

    mapBloc.add(OnCreateRoute(duration, distance, coords));
    Navigator.pop(context);
    searchBloc.add(OnDeactivateMarker());
  }
}
