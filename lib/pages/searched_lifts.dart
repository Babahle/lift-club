import 'package:flutter/material.dart';
import 'package:lifts_app/pages/lift_details.dart';
import 'package:provider/provider.dart';

import '../model/lift.dart';

class SearchedLifts extends SearchDelegate {
  SearchedLifts({required this.lifts});

  final Future<List<Lift>> lifts;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    
    return FutureBuilder<List<Lift>>(
      future: lifts,
      builder: (context, AsyncSnapshot<List<Lift>> snapshot) {
        if (snapshot.hasData) {
          List lifts = snapshot.data!;

          List<Lift> matchQuery = [];

          for (var lift in lifts) {
            if (lift.destinationTown
                .toLowerCase()
                .contains(query.toLowerCase())) {
              matchQuery.add(lift);
            }
          }
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          LiftDetailsView(liftId: result.id)));
                },
                child: ListTile(
                  title: Text(
                      "${result.destinationStreet} ${result.destinationTown}"),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Lift>>(
      future: lifts,
      builder: (context, AsyncSnapshot<List<Lift>> snapshot) {
        if (snapshot.hasData) {
          List lifts = snapshot.data!;

          List<Lift> matchQuery = [];

          for (var lift in lifts) {
            if (lift.destinationTown
                .toLowerCase()
                .contains(query.toLowerCase())) {
              matchQuery.add(lift);
            }
          }
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          LiftDetailsView(liftId: result.id)));
                },
                child: ListTile(
                  title: Text(
                      "${result.destinationStreet} ${result.destinationTown}"),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
