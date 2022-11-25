import 'package:lifts_app/model/booking.dart';
import 'package:lifts_app/model/lift.dart';
import "package:test/test.dart";

void main() {
  group("Lift Creation Tests", () {
    var normalLift = {
      'departureDateTime': DateTime.now().toIso8601String(),
      'ownerId': "123",
      'departureStreet': "958 Plum Street",
      'departureTown': "Ebony Park",
      'destinationStreet': "2907 Morogo Street",
      'destinationTown': "Pimville",
      'numberOfPassengers': 0,
      'seatsAvailable': 3
    };

    var liftWithNoSeatsAvailable = {
      'departureDateTime': DateTime.now().toIso8601String(),
      'ownerId': "123",
      'departureStreet': "958 Plum Street",
      'departureTown': "Ebony Park",
      'destinationStreet': "2907 Morogo Street",
      'destinationTown': "Pimville",
      'numberOfPassengers': 3,
      'seatsAvailable': 0
    };

    test("Create a Booking", () {
      Lift lift = Lift.fromJson(normalLift);
      Booking? createdBooking = lift.createBooking("123");
      expect(createdBooking, isNot(null));
      expect((normalLift["numberOfPassengers"] as int) + 1, lift.numberOfPassengers);
      expect((normalLift["seatsAvailable"] as int) -1, lift.seatsAvailable);
    });

    test("Trying to Book With No Seats Available", () {
      Lift lift = Lift.fromJson(liftWithNoSeatsAvailable);
      print(lift);
      Booking? createdBooking = lift.createBooking("123");
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
