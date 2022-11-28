import 'package:xid/xid.dart';

class MockingHelper {
  var normalLift = {
    'departureDateTime': DateTime.now().toIso8601String(),
    'id': Xid.string(),
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
    'id': Xid.string(),
    'ownerId': "123",
    'departureStreet': "958 Plum Street",
    'departureTown': "Ebony Park",
    'destinationStreet': "2907 Morogo Street",
    'destinationTown': "Pimville",
    'numberOfPassengers': 3,
    'seatsAvailable': 0
  };
}
