
part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}


class OnActivateMarker extends SearchEvent{}

class OnDeactivateMarker extends SearchEvent{}