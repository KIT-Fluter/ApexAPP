import 'package:cloud_firestore/cloud_firestore.dart';

class Rank {
  Rank(this.rank);

  String rank;
}

class RankPoint {
  RankPoint(DocumentSnapshot doc) {
    documentId = doc.id;
    sum = doc.data()["sum"];
    result = doc.data()["result"];
  }

  String documentId;
  int sum;
  Map result;
}

//mapの型
class ResultType {
  String id;
  String date;
  int point;
}
