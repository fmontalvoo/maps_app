part of 'widgets.dart';

class RouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapBloc>();
    // final ubicationBloc = context.watch<UbcationBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25.0,
        child: IconButton(
          icon: Icon(Icons.alt_route, color: Colors.black87),
          onPressed: () {
            mapBloc.add(OnDrawPath());
          },
        ),
      ),
    );
  }
}
