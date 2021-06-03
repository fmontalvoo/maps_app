part of 'widgets.dart';

class FollowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final ubicationBloc = context.watch<UbcationBloc>();

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) => btnFollow(context, state),
    );
  }

  Widget btnFollow(BuildContext context, MapState state) {
    return MaterialButton(
      padding: EdgeInsets.all(12.0),
      color: Colors.white,
      shape: CircleBorder(),
      child: Icon(state.followLocation ? Icons.navigation : Icons.directions,
          color: Colors.black87),
      onPressed: () {
        context.read<MapBloc>().add(OnFollowLocation());
      },
    );
  }
}
