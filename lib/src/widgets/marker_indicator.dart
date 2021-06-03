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
                child: Icon(Icons.location_on, size: 32.0))),
        Container(
          margin: EdgeInsets.only(bottom: 50.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              minWidth: size.width - 220,
              color: Colors.black,
              textColor: Colors.white,
              shape: StadiumBorder(),
              child: Text('Confirmar'),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
