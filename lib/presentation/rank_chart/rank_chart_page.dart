import 'package:apex_app/presentation/rank_chart/rank_chart_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../battle_record/battle_record_page.dart';
import '../input/input_page.dart';
import '../rank_chart/rank_chart_model.dart';
import '../setting/setting_page.dart';

class RankChartPage extends StatefulWidget {
  RankChartPage(this.data);
  final List<LinearSales> data;
  //RankChartRecordPage(this.score);
  //final List score;

  @override
  _RankChartPageState createState() => _RankChartPageState(this.data);
}

class _RankChartPageState extends State<RankChartPage> {
  int _selectedIndex = 3;
  List<LinearSales> rankPointList = [];
  _RankChartPageState(this.rankPointList);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BattleRecordPage([]);
        }));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return InputPage();
        }));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SettingPage();
        }));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RankChartPage([]);
        }));
        break;
    }
  }

  List convertMapToArray(mapRunkResultArray) {
    List<LinearSales> resultArray = [];
    for (var i = 0; i < mapRunkResultArray.length; i++) {
      resultArray.add(
        LinearSales(i, mapRunkResultArray[i]["sum"]),
      );
    }
    return resultArray;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RankChartModel()
        ..fetchRank()
        ..fetchRankPointArray("guest"),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ランク"),
        ),
        body: Consumer<RankChartModel>(builder: (context, model, child) {
          return Column(
            children: <Widget>[
              Center(child: Text("ランクグラフ")),
              Container(
                child: SimpleLineChart(
                    _chartData(convertMapToArray(model.rankPointsArray))),
                height: 400,
              ),
              RaisedButton(
                child: Text("戦歴を全て削除"),
                onPressed: () {
                  Navigator.pop(context);
                  model.deleteAllRankPoint("guest");
                },
              ),
              //TODO: ListViewがおかしいので修正
              /*ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${rankPointList[index]}"),
                      //title: Text('aaa'),
                    );
                  },
                )*/
            ],
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

//TODO: Chartの理解
//後々はDataChartに変更
class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

List<charts.Series<LinearSales, int>> _chartData(
    List<LinearSales> rankPointList) {
  return [
    new charts.Series<LinearSales, int>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: rankPointList,
    )
  ];
}
