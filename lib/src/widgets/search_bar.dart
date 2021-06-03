part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) => state.manualSelection
            ? Container()
            : FadeInDown(child: _searchBar(context)));
  }

  Widget _searchBar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            alignment: Alignment.center,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5.0,
                      offset: Offset(0, 5.0))
                ]),
            child: TextField(
              decoration: InputDecoration(
                  enabled: false,
                  // prefixIcon: Icon(Icons.directions),
                  suffixIcon: Icon(Icons.search),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: '¿Donde quieres ir?'),
            ),
          ),
          onTap: () async {
            returnResult(context,
                await showSearch(context: context, delegate: SearchLocation()));
          },
        ),
      ),
    );
  }

  void returnResult(BuildContext context, ResultSearch result) {
    if (result.canceled) return;

    if (result.manual) context.read<SearchBloc>().add(OnActivateMarker());
  }
}
