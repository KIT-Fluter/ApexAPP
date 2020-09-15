import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../battle_record/battle_record_page.dart';
import '../rank_chart/rank_chart_page.dart';
import '../setting/setting_page.dart';
import 'input_model.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int _selectedIndex = 1;
  int damage = 0;
  int killCount = 0;
  int deathCount = 0;
  List lists = [];
  int rankPoint = 0;
  int count = 0;
  int sum = 0;
  List<LinearSales> rankPointList = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BattleRecordPage([lists])),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InputPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RankChartPage([])),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InputModel()..fetchRankPointArray("guest"),
      child: Scaffold(
        appBar: AppBar(
          title: Text("入力"),
        ),
        body: Consumer<InputModel>(builder: (context, model, child) {
          return Center(
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "ダメージ数"),
                    //TODO: 重たくなるので代替案を考える
                    onChanged: (value) {
                      damage = int.parse(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "キル数"),
                    onChanged: (value) {
                      killCount = int.parse(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "死亡回数"),
                    onChanged: (value) {
                      deathCount = int.parse(value);
                    },
                  ),
                  RaisedButton(
                    child: Text("戦績の追加"),
                    onPressed: () {
                      lists = [damage, killCount, deathCount];
                      print(lists);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BattleRecordPage([]);
                          },
                        ),
                      );
                    },
                  ),
                  //ランク用
                  TextFormField(
                    decoration: InputDecoration(labelText: "ユーザー名"),
                    //TODO: 重たくなるので代替案を考える
                    onChanged: (value) {
                      rankPoint = int.parse(value);
                    },
                  ),
                  RaisedButton(
                    child: Text("戦績の追加"),
                    onPressed: () {
                      model.addRankPoint(
                          this.rankPoint,
                          "guest",
                          model.latestSum + this.rankPoint,
                          model.rankPointsArray);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RankChartPage(rankPointList);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              title: Text('戦績'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.input),
              title: Text('入力'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('設定'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.equalizer),
              title: Text('ランク'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
