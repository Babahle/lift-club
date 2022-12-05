import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lifts_app/model/booking.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/repository/lifts_repository.dart';
import 'package:provider/provider.dart';

class LiftsViewModel extends ChangeNotifier {
  final LiftsRepository _liftsRepository = LiftsRepository();

  static Stream<List<Lift>> getAllLiftsAsStream() {
    LiftsRepository staticLiftsRepository = LiftsRepository();
    return staticLiftsRepository.getAllLifts().asStream();
  }

  Future<List<Lift>> getAllLifts() {
    return _liftsRepository.getAllLifts();
  }

  void addLiftToDatabase(Lift lift) {
    _liftsRepository.addLiftToCollection(lift);
    notifyListeners();
  }

  Stream<QuerySnapshot> getLiftStream() {
    return _liftsRepository.getLiftStream();
  }

  Future<List<Lift>> getLiftsForUser(String id) {
    return _liftsRepository.getLiftsFromOwnerId(id);
  }

  Future<Lift> getLiftFromId(String id) async {
    return await _liftsRepository.getLiftFromId(id);
  }

  updateLift(Lift lift) {
    _liftsRepository.updateLift(lift);
  }

  deleteLift(Lift lift) {
    _liftsRepository.deleteLift(lift);
  }
}
