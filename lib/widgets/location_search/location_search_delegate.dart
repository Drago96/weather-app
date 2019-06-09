import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/blocs/location_search/location_search_bloc.dart';
import 'package:weather_app/blocs/location_search/location_search_event.dart';
import 'package:weather_app/blocs/location_search/location_search_state.dart';
import 'package:weather_app/models/location.dart';

class LocationSearchDelegate extends SearchDelegate<Location> {
  final locationSearchBloc = LocationSearchBloc();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

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
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Widget _centeredMessage(BuildContext context, String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _locationsList(BuildContext context, LocationSearchState state) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: state.locations.length,
      itemBuilder: (_, index) {
        final location = state.locations.elementAt(index);

        return ListTile(
          leading: Icon(Icons.location_city),
          title: Text(location.name),
          onTap: () {
            close(context, location);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length == 0) {
      return _centeredMessage(
        context,
        "Please start typing a location's name.",
      );
    }

    locationSearchBloc.dispatch(FetchLocations(searchTerm: query));

    return BlocBuilder(
      bloc: locationSearchBloc,
      builder: (_, LocationSearchState state) {
        if (state is LocationsError) {
          return _centeredMessage(context, state.error);
        }

        if (state is LocationsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.locations.isEmpty) {
          return _centeredMessage(context, "No locations match your search.");
        }

        return _locationsList(context, state);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length == 0) {
      locationSearchBloc.dispatch(ResetLocations());

      return Container();
    }

    locationSearchBloc.dispatch(FetchLocationsSuggestions(searchTerm: query));

    return BlocBuilder(
      bloc: locationSearchBloc,
      builder: (_, LocationSearchState state) {
        if (state is LocationsError) {
          return _centeredMessage(context, state.error);
        }

        return _locationsList(context, state);
      },
    );
  }
}
