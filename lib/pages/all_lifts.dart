// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:lifts_app/custom_widgets/lift_card.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

class AllLiftsView extends StatefulWidget {
  const AllLiftsView({super.key});

  @override
  State<AllLiftsView> createState() => _AllLiftsViewState();
}

class _AllLiftsViewState extends State<AllLiftsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(
            "Available Lifts",
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(child: _buildLiftStreamBuilder(context)),
        ],
      ),
    ));
  }

  StreamBuilder<QuerySnapshot<Object?>> _buildLiftStreamBuilder(
      BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Provider.of<LiftsViewModel>(context).getLiftStream(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<Lift?> lifts =
                snapshot.data!.docs.map((DocumentSnapshot document) {
              return Lift.fromJson(document.data() as Map<String, dynamic>);
            }).toList();

            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: lifts.length,
                itemBuilder: ((context, index) {
                  var lift = lifts[index];
                  String destination =
                      "${lift!.destinationStreet} ${lift.destinationTown}";
                  String departure =
                      "${lift!.departureStreet} ${lift!.departureTown}";
                  return LiftCard(
                    departure: departure,
                    destination: destination,
                  );
                }));
          } else {
            return const CircularProgressIndicator();
          }
        }));
  }
}
