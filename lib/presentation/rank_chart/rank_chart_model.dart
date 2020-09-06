import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../domein/rank.dart';

class RankChartModel extends ChangeNotifier {
  String aa = "aaaaa!";
  List<Rank> ranks = [];

  void changeAA() {
    aa = "bb";
    notifyListeners();
  }

  Future fetchRank() async {
    await Firebase.initializeApp();
    final QuerySnapshot docs1 =
        await FirebaseFirestore.instance.collection("rank").get();
    final ranks = docs1.docs[0].data()['title'];
    //final ranks2 = docs1.docs.map((doc) => Rank(doc.data()["title"])).toList();
    this.aa = ranks;
    //this.ranks = ranks2;
    notifyListeners();
  }

  Future addRank() async {
    FirebaseFirestore.instance.collection('rank').add({"title": "Legends"});
    notifyListeners();
  }
}
