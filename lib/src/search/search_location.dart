import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:maps_app/src/models/result_search.dart';
import 'package:maps_app/src/models/places_response.dart';

import 'package:maps_app/src/services/traffic_service.dart';

class SearchLocation extends SearchDelegate<ResultSearch> {
  @override
  final String searchFieldLabel;

  final TrafficService _trafficService;

  final LatLng proximity;

  SearchLocation({this.proximity})
      : this.searchFieldLabel = 'Buscar',
        this._trafficService = new TrafficService();

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
    return buildResultsSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty)
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

    return buildResultsSuggestions();
  }

  Widget buildResultsSuggestions() {
    if (query.isEmpty) return Container();

    _trafficService.getSuggestions(query, proximity);

    return StreamBuilder<PlacesResponse>(
      stream: _trafficService.suggestions,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        final places = snapshot.data.features;

        if (places.isEmpty)
          return ListTile(
            leading: Icon(Icons.warning),
            title: Text('No hay resultados con $query'),
          );

        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(places[index].textEs),
              subtitle: Text(places[index].placeNameEs),
              onTap: () {
                print(places[index].type);
              },
            );
          },
        );
      },
    );
  }
}
