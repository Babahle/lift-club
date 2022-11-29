import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lifts_app/model/booking.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/repository/lifts_repository.dart';

class LiftsViewModel extends ChangeNotifier {
  final List<Lift> lifts = [];
  final LiftsRepository _liftsRepository = LiftsRepository();

  addLiftToDatabase(Lift lift) {
    _liftsRepository.addLiftToCollection(lift);
    notifyListeners();
  }

  Stream<QuerySnapshot> getLiftStream() {
    return _liftsRepository.getLiftStream();
  }

  Future<Lift> getLiftFromId(String id) async {
    return await _liftsRepository.getLiftFromId(id);
  }

  updateLift(Lift lift)  {
     _liftsRepository
      .updateLift(lift);
  }

}
