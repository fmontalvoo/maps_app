import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'ubication_state.dart';
part 'ubication_event.dart';

class UbcationBloc extends Bloc<UbicationEvent, UbicationState> {
  UbcationBloc() : super(UbicationState());

  @override
  Stream<UbicationState> mapEventToState(UbicationEvent event) async* {}
}
