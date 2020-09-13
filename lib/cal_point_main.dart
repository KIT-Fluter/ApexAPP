//ランクポイント計算
int getRankPoint(int ranking, int killCount, int assistCount, String rankBelt, bool isRetire, bool isExemption){
  //最終順位による順位ポイント
  int rankPoint(int ranking){
    if(ranking > 10){
      return 0;
    }else if(ranking < 8 && ranking >= 10){
      return 10;
    }else if(ranking < 6 && ranking >= 8){
      return 20;
    }else if(ranking < 4 && ranking >= 6){
      return 30;
    }else if(ranking < 2 && ranking >= 4){
      return 40;
    }else if(ranking == 2){
      return 60;
    }else{
      return 100;
    }
  }

  //キルポの計算
  int killPoint(int killCount, int assistCount){
    int killPoint = killCount + assistCount;

    if(killPoint >= 5){
      return 5;
    }else{
      return killPoint;
    }
  }

  //キルポイントの倍率
  double killMag(int ranking){
    if(ranking > 10){
      return 1.0;
    }else if(ranking < 5 && ranking >= 10){
      return 1.2;
    }else if(ranking < 3 && ranking >= 5){
      return 1.5;
    }else if(ranking < 1 && ranking >= 3){
      return 2.0;
    }else{
      return 2.5;
    }
  }

  //ランクマッチの参加コストpart1
  int rankCost(String rankBelt){
    if(rankBelt == 'bronze'){
      return 0;
    }else if(rankBelt == 'silver'){
      return 12;
    }else if(rankBelt == 'gold'){
      return 24;
    }else if(rankBelt == 'platinum'){
      return 36;
    }else if(rankBelt == 'diamond'){
      return 48;
    }else if(rankBelt == 'master' || rankBelt == 'predator'){
      return 60;
    }
  }

  //ランクマッチの参加コストpart2
  /*int rankCost(int rankScore){
    if(rankScore < 1200){
      return 0; //ブロンズ
    }else if(rankScore < 2800 && rankScore >= 1200){
      return 12; //シルバー
    }else if(rankScore < 4800 && rankScore >= 2800){
      return 24; //ゴールド
    }else if(rankScore < 7200 && rankScore >= 4800){
      return 36; //プラチナ
    }else if(rankScore < 100000 && rankScore >= 7200){
      return 48; //ダイヤ
    }else{
      return 60; //マスター，プレデター
    }
  }*/

  //集計
  int totalScore = rankPoint(ranking) + (killPoint(killCount, assistCount) * (10*killMag(ranking)).floor()) - rankCost(rankBelt);

  //切断ペナルティ
  if(isRetire == true){
    totalScore = -rankCost(rankBelt)*2;
  }
  
  //敗北免除
  if(isExemption == true && totalScore < 0){
    totalScore = 0;
  }

  return totalScore;
}




//現在のランク計算
String getRankBelt(int allRankPoint){
  if(allRankPoint < 1200){
    return 'bronze';
  }else if(allRankPoint < 2800 && allRankPoint >= 1200){
    return 'silver';
  }else if(allRankPoint < 4800 && allRankPoint >= 2800){
    return 'gold';
  }else if(allRankPoint < 7200 && allRankPoint >= 4800){
    return 'platinum';
  }else if(allRankPoint < 10000 && allRankPoint >= 7200){
    return 'diamond';
  }else{
    return 'master';
  }
}



//降格免除
int saveRank(int totalRankPoint, int getRankPoint){
  int allRankPoint = totalRankPoint + getRankPoint;

  if(totalRankPoint >= 1200 && allRankPoint < 1200){
    allRankPoint = 1200;
  }else if(totalRankPoint >= 2800 && allRankPoint < 2800){
    allRankPoint = 2800;
  }else if(totalRankPoint >= 4800 && allRankPoint < 4800){
    allRankPoint = 4800;
  }else if(totalRankPoint >= 7200 && allRankPoint < 7200){
    allRankPoint = 7200;
  }else if(totalRankPoint >= 10000 && allRankPoint < 10000){
    allRankPoint = 10000;
  }

  return allRankPoint;
}

