import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'rank_charts.dart';
import 'setting_screen.dart';

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
  int rank_point = 0;
  int count = 0;
  int sum = 0;
  List<LinearSales> rank_point_list = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BattleRecordPage(lists);
            },
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return InputPage();
            },
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SettingPage();
            },
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("入力"),
      ),
      body: Center(
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
              TextFormField(
                decoration: InputDecoration(labelText: "ポイント"),
                //TODO: 重たくなるので代替案を考える
                onChanged: (value) {
                  rank_point = int.parse(value);
                },
              ),
              RaisedButton(
                child: Text("戦績の追加"),
                onPressed: () {
                  count++;
                  //rank_point_list.add([count, rank_point]);
                  sum += rank_point;
                  rank_point_list.add(LinearSales(count - 1, sum));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RankChartPage(rank_point_list);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
