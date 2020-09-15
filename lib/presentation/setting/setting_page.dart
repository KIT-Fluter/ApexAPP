import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../battle_record/battle_record_page.dart';
import '../input/input_page.dart';
import '../rank_chart/rank_chart_page.dart';
import 'setting_model.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int _selectedIndex = 2;
  List rankPointList;
  int rankPoint;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BattleRecordPage([])),
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
      create: (_) => SettingModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("設定"),
        ),
        body: Consumer<SettingModel>(builder: (context, model, child) {
          return Center(
            child: Form(
              child: Column(
                children: <Widget>[
                  Text(model.userName),
                  TextFormField(
                    decoration: InputDecoration(labelText: "ポイント"),
                    //TODO: 重たくなるので代替案を考える
                    onChanged: (value) {
                      model.userName = value;
                    },
                  ),
                  RaisedButton(
                    child: Text("戦績の追加"),
                    onPressed: () {
                      model.addUserName(model.userName);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RankChartPage(rankPointList)),
                      );
                      model.userName = "";
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
