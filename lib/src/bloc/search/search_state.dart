part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool manualSelection;
  final List<ResultSearch> history;

  SearchState({
    this.manualSelection = false,
    List<ResultSearch> history,
  }) : this.history = (history != null) ? history : [];

  SearchState copyWith({
    bool manualSelection,
    List<ResultSearch> history,
  }) =>
      new SearchState(
        history: history ?? this.history,
        manualSelection: manualSelection ?? this.manualSelection,
      );
}
