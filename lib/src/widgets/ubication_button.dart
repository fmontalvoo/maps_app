part of 'widgets.dart';

class UbicationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapBloc>();
    final ubicationBloc = context.watch<UbcationBloc>();

    return MaterialButton(
        padding: EdgeInsets.all(12.0),
        color: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.my_location, color: Colors.black87),
        onPressed: () {
          final latLng = ubicationBloc.state.latLng;
          mapBloc.moveCamera(latLng);
        });
  }
}
