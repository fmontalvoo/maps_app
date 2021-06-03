import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OnActivateMarker) yield state.copyWith(manualSelection: true);
    if (event is OnDeactivateMarker)
      yield state.copyWith(manualSelection: false);
  }
}
