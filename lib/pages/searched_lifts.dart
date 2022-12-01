import 'package:flutter/material.dart';
import 'package:lifts_app/pages/lift_details.dart';
import 'package:provider/provider.dart';

import '../model/lift.dart';

class SearchedLifts extends SearchDelegate {
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];
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
    List<Lift> matchQuery = [];

    List<Lift> lifts = Provider.of<List<Lift>>(context);
    for (var lift in lifts) {
      if (lift.destinationTown.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(lift);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.destinationTown),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Lift> matchQuery = [];

    List<Lift> lifts = Provider.of<List<Lift>>(context);
    for (var lift in lifts) {
      if (lift.destinationTown.toLowerCase().contains(query.toLowerCase())) {
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
                builder: (context) => LiftDetailsView(liftId: result.id)));
          },
          child: ListTile(
            title: Text(result.destinationTown),
          ),
        );
      },
    );
  }
}
