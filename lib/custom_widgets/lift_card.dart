import 'package:flutter/material.dart';
import 'package:lifts_app/pages/lift_details.dart';

class LiftCard extends StatelessWidget {
  const LiftCard({Key? key, required this.departure, required this.destination, required this.liftId})
      : super(key: key);

  final String departure;
  final String destination;
  final String liftId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>  LiftDetailsView(liftId: liftId,)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.place),
                  Text(
                    "Departure",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                departure,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.place),
                  Text(
                    "Destination",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                destination,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ),
    );
  }
}
