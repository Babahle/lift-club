import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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

  void updateLift(Lift lift) async {
    QuerySnapshot<Lift> snapshot =
        await liftsReference.where("id", isEqualTo: lift.id).get();



    String liftDocId = snapshot.docs.elementAt(0).id;

    liftsReference.doc(liftDocId).update({
      "departureDateTime": lift.departureDateTime.toIso8601String(),
      "departureStreet": lift.departureStreet,
      "departureTown": lift.departureTown,
      "destinationStreet": lift.destinationStreet,
      "destinationTown": lift.destinationTown,
      "numberOfPassengers": lift.numberOfPassengers,
      "seatsAvailable": lift.seatsAvailable
    });
  }

  void deleteLift(Lift lift) async {
    QuerySnapshot<Lift> snapshot =
        await liftsReference.where("id", isEqualTo: lift.id).get();
    String liftDocId = snapshot.docs.elementAt(0).id;
    liftsReference.doc(liftDocId).delete();
  }

  Future<List<Lift>> getLiftsFromId(String id) {
    var stream = FirebaseFirestore.instance
        .collection('lifts')
        .withConverter<Lift>(
            fromFirestore: (snapshot, _) => Lift.fromJson(snapshot.data()!),
            toFirestore: (lift, _) => lift.toJson())
        .where("ownerId", isEqualTo: id)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    return stream;
  }




  Future<Lift> getLiftFromId(String id) {
    return liftsReference
        .where("id", isEqualTo: id)
        .get()
        .then((snapshot) => snapshot.docs.map((e) => e.data()).toList()[0],
            onError: (e) {
      logger.e("Error trying to get lift $e");
    });
  }
}
