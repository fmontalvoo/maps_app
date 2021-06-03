part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            returnResult(
                await showSearch(context: context, delegate: SearchLocation()));
          },
        ),
      ),
    );
  }

  void returnResult(ResultSearch result) {
    if (result.canceled) return;
  }
}
