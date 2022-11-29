import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:lifts_app/model/bookings_view_model.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/services/authentication.dart';
import 'package:provider/provider.dart';

import '../model/booking.dart';

class LiftDetailsView extends StatelessWidget {
  const LiftDetailsView({super.key, required this.liftId});
  final String liftId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<LiftsViewModel>(
            builder: ((context, liftsViewModel, child) {
              Future<Lift> lift = liftsViewModel.getLiftFromId(liftId);
              return FutureBuilder(
                  future: lift,
                  builder: ((context, AsyncSnapshot<Lift> snapshot) {
                    if (snapshot.hasData) {
                      return _buildLiftDetails(context, snapshot.data);
                    }

                    return Container(
                      width: 0.0,
                      height: 0.0,
                    );
                  }));
            }),
          )),
    );
  }

  Column _buildLiftDetails(BuildContext context, Lift? lift) {
    return Column(children: <Widget>[
      Text(
        "Lift Details",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton.icon(
            onPressed: () async {
              bool booked = false;
              String id =
                  Provider.of<AuthenticationService>(context, listen: false)
                      .getUserId()!;

              List<Booking> bookings =
                  await Provider.of<BookingViewModel>(context, listen: false)
                      .getBookingsFromUserId(id);

              for (Booking booking in bookings) {
                if (booking.ownerId == id && liftId == booking.liftId) {
                  booked = true;
                }
              }

              if (booked) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You've Already Booked This lift")));
              } else {
                Booking createdBooking = lift!.createBooking(id)!;
                Provider.of<BookingViewModel>(context, listen: false)
                    .addBookingToDatabase(createdBooking);
              }
            },
            label: const Text("Book"),
            icon: const Icon(Icons.check),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
            onPressed: () {
              //TODO: Cancel The Booking;
            },
            label: const Text("Cancel"),
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      ListTile(
        title: const Text("Driver"),
        subtitle: Text(lift!.ownerEmail),
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[Icon(Icons.time_to_leave)]),
      ),
      const SizedBox(
        height: 20,
      ),
      ListTile(
        title: const Text("Departure"),
        subtitle: Text("${lift.departureStreet} ${lift.departureTown}"),
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[Icon(Icons.place)]),
      ),
      const SizedBox(
        height: 20,
      ),
      ListTile(
        title: const Text("Destination"),
        subtitle: Text("${lift.destinationStreet} ${lift.destinationTown}"),
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[Icon(Icons.place)]),
      ),
      const SizedBox(
        height: 20,
      ),
      ListTile(
        title: const Text("Departure Date & Time"),
        subtitle: Text(
            " ${DateFormat.MMMd().format(lift.departureDateTime)}, ${DateFormat.Hm().format(lift.departureDateTime)}"),
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[Icon(Icons.timelapse)]),
      ),
      const SizedBox(
        height: 20,
      ),
      ListTile(
        title: const Text("No. Seats Available"),
        subtitle: Text(lift.seatsAvailable.toString()),
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[Icon(Icons.person)]),
      ),
    ]);
  }
}
