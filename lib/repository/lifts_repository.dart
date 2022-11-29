import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:logger/logger.dart';

class LiftsRepository {
  var logger = Logger();

  Stream<QuerySnapshot> liftsStream =
      FirebaseFirestore.instance.collection("lifts").snapshots();

  var liftsReference = FirebaseFirestore.instance
      .collection("lifts")
      .withConverter<Lift>(
          fromFirestore: (snapshot, _) => Lift.fromJson(snapshot.data()!),
          toFirestore: (lift, _) => lift.toJson());

  Stream<QuerySnapshot> getLiftStream() {
    return liftsStream;
  }

  Future<List<QuerySnapshot>> getAllAvailableLifts() {
    return liftsStream.toList();
  }

  Future<void> addLiftToCollection(Lift lift) async {
    await liftsReference.add(lift);
  }

  Future<Lift> getLiftFromId(String id) {
    logger.i("Getting Lift with $id as the id");
    return liftsReference
        .where("id", isEqualTo: id)
        .get()
        .then((snapshot) => snapshot.docs.map((e) => e.data()).toList()[0],
            onError: (e) {
      logger.e("Error trying to get lift $e");
    });
  }
}
