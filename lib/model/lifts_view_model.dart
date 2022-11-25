import 'package:flutter/foundation.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/repository/lifts_repository.dart';

class LiftsViewModel extends ChangeNotifier {
  final List<Lift> lifts = [];
  final LiftsRepository _liftsRepository = LiftsRepository();

  addLiftToDatabase(Lift lift) {
    _liftsRepository.addLiftToCollection(lift);
  }

  Future<List<Lift>> getAllLifts() async {
    List<Lift> newLifts = await _liftsRepository.getAllAvailableLifts();
    for (final lift in newLifts) {
      lifts.add(lift);
    }
    notifyListeners();
    return lifts;
  }
}
