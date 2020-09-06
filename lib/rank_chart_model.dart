import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'rank.dart';

class RankChartModel extends ChangeNotifier {
  String aa = "aaaaa!";
  List<Rank> ranks = [];

  void changeAA() {
    aa = "bb";
    notifyListeners();
  }

  Future fetchRank() async {
    final QuerySnapshot docs1 =
        await FirebaseFirestore.instance.collection("rank").get();
    final ranks = docs1.docs.map((doc) => Rank(doc.data()['title']));
    this.ranks = ranks;
    notifyListeners();
  }
}
