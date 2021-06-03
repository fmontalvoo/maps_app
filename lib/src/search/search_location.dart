import 'package:flutter/material.dart';

import 'package:maps_app/src/models/result_search.dart';

class SearchLocation extends SearchDelegate<ResultSearch> {
  @override
  final String searchFieldLabel;

  SearchLocation() : this.searchFieldLabel = 'Buscar';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () => this.close(context, ResultSearch(canceled: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Ubicación'),
          onTap: () {
            this.close(context, ResultSearch(canceled: false, manual: true));
          },
        )
      ],
    );
  }
}
