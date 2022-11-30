import 'package:flutter/material.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/edit_lift.dart';
import 'package:lifts_app/pages/lift_details.dart';
import 'package:provider/provider.dart';

class LiftCardWithButtons extends StatelessWidget {
  const LiftCardWithButtons(
      {Key? key,
      required this.departure,
      required this.destination,
      required this.liftId})
      : super(key: key);

  final String departure;
  final String destination;
  final String liftId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LiftDetailsView(
                  liftId: liftId,
                )));
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Consumer<LiftsViewModel>(
                    builder: (context, model, child) {
                      return IconButton(
                          onPressed: () async {
                            Lift lift = await model.getLiftFromId(liftId);
                            model.deleteLift(lift);
                          },
                          icon: Icon(Icons.delete));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Consumer<LiftsViewModel>(
                    builder: (context, model, child) {
                      return IconButton(
                          onPressed: () async {
                            Lift lift = await model.getLiftFromId(liftId);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    EditLiftView(lift: lift))));
                          },
                          icon: Icon(Icons.edit));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LiftCardWithoutButtons extends StatelessWidget {
  const LiftCardWithoutButtons(
      {Key? key,
      required this.departure,
      required this.destination,
      required this.liftId})
      : super(key: key);

  final String departure;
  final String destination;
  final String liftId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LiftDetailsView(
                  liftId: liftId,
                )));
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
