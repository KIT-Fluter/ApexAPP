import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../domein/rank.dart';

class RankChartModel extends ChangeNotifier {
  String aa = "aaaaa!";
  List<Rank> ranks = [];
  List rankPointsArray = [];
  int sum = 0;
  int latestSum = 0;

  Future fetchRank() async {
    await Firebase.initializeApp();
    final QuerySnapshot docs =
        await FirebaseFirestore.instance.collection("rank").get();
    this.aa = docs.docs[0].data()['title'];
    notifyListeners();
  }

  Future fetchRankPointArray(String name) async {
    await Firebase.initializeApp();
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("rankPointArray")
        .doc("guest")
        .get();
    this.rankPointsArray = doc.data()["rankResult"];
    this.latestSum = doc.data()["latestSum"];
    notifyListeners();
  }

  Future addRank() async {
    FirebaseFirestore.instance.collection('rank').add({"title": "Legends"});
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

  Future deleteAllRankPoint(String name) {
    FirebaseFirestore.instance.collection('rankPointArray').doc(name).set(
      {
        "documentId": name,
        "rankResult": [
          {"date": DateTime.now(), "point": 0, "sum": 0}
        ],
        "latestSum": 0
      },
    );
    //FirebaseFirestore.instance.collection('rankPointArray').doc(name).delete();
    notifyListeners();
  }
}
