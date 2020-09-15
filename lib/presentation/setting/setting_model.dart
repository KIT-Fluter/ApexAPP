import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SettingModel extends ChangeNotifier {
  String userName = "asd";

  Future fetchRankPointArray(String name) async {
    await Firebase.initializeApp();
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("rankPointArray")
        .doc("guest")
        .get();
    //this.rankPointsArray = doc.data()["rankResult"];
    //this.latestSum = doc.data()["latestSum"];
    notifyListeners();
  }

  Future addUserName(String userName) async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.collection('rankPointArray').doc(userName).set(
      {"userName": userName},
    );
    notifyListeners();
  }
}
