import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/src/models/result_search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OnActivateMarker) yield state.copyWith(manualSelection: true);
    if (event is OnDeactivateMarker)
      yield state.copyWith(manualSelection: false);

    if (event is OnSaveHistory) {
      final exists = state.history
          .where((result) => result.latLng == event.result.latLng)
          .length;

      if (exists == 0) {
        final history = [...state.history, event.result];
        yield state.copyWith(history: history);
      }
    }
  }
}
