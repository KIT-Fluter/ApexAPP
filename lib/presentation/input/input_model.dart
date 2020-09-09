import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../domein/rank.dart';

class InputModel extends ChangeNotifier {
  String aa = "aaaaa!";
  List<Rank> ranks = [];
  List rankPointsArray = [];
  int sum = 0;
  int latestSum = 0;

  Future fetchRankPointArray(String name) async {
    await Firebase.initializeApp();
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("rankPointArray")
        .doc("guest")
        .get();
    this.rankPointsArray = doc.data()["rankResult"];
    this.latestSum = doc.data()["latestSum"];
    if (this.rankPointsArray.length == 0) {
      addRankPoint(0, "guest", 0, []);
    }
    notifyListeners();
  }

  Future addRankPoint(
      int point, String name, int latestSum, List beforeResultArray) async {
    FirebaseFirestore.instance.collection('rankPointArray').doc(name).set(
      {
        "documentId": name,
        "rankResult": [
          ...beforeResultArray,
          {"date": DateTime.now(), "point": point, "sum": latestSum}
        ],
        "latestSum": latestSum
      },
    );
    notifyListeners();
  }
}
