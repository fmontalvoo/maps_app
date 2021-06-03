part of 'widgets.dart';

class RouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapBloc>();
    // final ubicationBloc = context.watch<UbcationBloc>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.0),
      child: MaterialButton(
          padding: EdgeInsets.all(12.0),
          color: Colors.white,
          shape: CircleBorder(),
          child: Icon(Icons.alt_route, color: Colors.black87),
          onPressed: () {
            mapBloc.add(OnDrawPath());
          }),
    );
  }
}
