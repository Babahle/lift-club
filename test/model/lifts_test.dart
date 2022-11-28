import 'package:lifts_app/model/booking.dart';
import 'package:lifts_app/model/lift.dart';
import "package:test/test.dart";

import '../mocking_helper.dart';

void main() {
  group("Lift Creation Tests", () {

    MockingHelper helper = MockingHelper();

    var normalLift = helper.normalLift;
    var liftWithNoSeatsAvailable = helper.liftWithNoSeatsAvailable;

    test("Create a Booking", () {
      Lift lift = Lift.fromJson(normalLift);
      Booking? createdBooking = lift.createBooking(lift.id.toString());
      expect(createdBooking, isNot(null));
      expect((normalLift["numberOfPassengers"] as int) + 1, lift.numberOfPassengers);
      expect((normalLift["seatsAvailable"] as int) -1, lift.seatsAvailable);
    });

    test("Trying to Book With No Seats Available", () {
      Lift lift = Lift.fromJson(liftWithNoSeatsAvailable);
      print(lift);
      Booking? createdBooking = lift.createBooking(lift.id.toString());
      expect(createdBooking, null);
      expect((liftWithNoSeatsAvailable["numberOfPassengers"] as int), lift.numberOfPassengers);
      expect((liftWithNoSeatsAvailable["seatsAvailable"] as int), lift.seatsAvailable);
    });

    test("Creating A Lift With fromJson", () {
      Lift createdLift = Lift.fromJson(normalLift);
      expect(normalLift, createdLift.toJson());
    });
  });
}
