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
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25.0,
        child: IconButton(
          icon: Icon(state.followLocation ? Icons.navigation : Icons.directions,
              color: Colors.black87),
          onPressed: () {
            context.read<MapBloc>().add(OnFollowLocation());
          },
        ),
      ),
    );
  }
}
