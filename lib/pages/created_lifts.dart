import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:lifts_app/custom_widgets/lift_card.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/services/authentication.dart';
import 'package:provider/provider.dart';

class CreatedLiftsView extends StatefulWidget {
  const CreatedLiftsView({super.key});

  @override
  State<CreatedLiftsView> createState() => _CreatedLiftsViewState();
}

class _CreatedLiftsViewState extends State<CreatedLiftsView> {
  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<AuthenticationService>(context).getUserId()!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Text(
              "Your Created Lifts",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<LiftsViewModel>(
              builder: ((context, liftModel, child) {
                Future<List<Lift>> lifts = liftModel.getLiftsForUser(userId);
                return FutureBuilder(
                    future: lifts,
                    builder: ((context, AsyncSnapshot<List<Lift>> snapshot) {
                      if (snapshot.hasData) {
                        return _buildLiftsLists(snapshot);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }));
              }),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildLiftsLists(AsyncSnapshot<List<Lift>> snapshot) {
    return Expanded(
      child: ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: ((context, index) {
            Lift lift = snapshot.data![index];
            String destination =
                "${lift.destinationStreet} ${lift.destinationTown}";
            String departure = "${lift.departureStreet} ${lift.departureTown}";
            return LiftCardWithButtons(
                departure: departure,
                destination: destination,
                liftId: lift.id);
          })),
    );
  }
}
