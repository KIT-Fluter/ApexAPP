import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'input_screen.dart';
import 'main_screen.dart';
import 'setting_screen.dart';

class RankChartPage extends StatefulWidget {
  RankChartPage({Key key, this.title}) : super(key: key);
  final String title;
  //RankChartRecordPage(this.score);
  //final List score;

  @override
  _RankChartPageState createState() => _RankChartPageState();
}

class _RankChartPageState extends State<RankChartPage> {
  int _selectedIndex = 0;
  int rank_point = 0;
  List<int> rank_point_list = [];

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
          return RankChartPage();
        }));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ランク"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "ダメージ数"),
                    //TODO: 重たくなるので代替案を考える
                    onChanged: (value) {
                      rank_point = int.parse(value);
                    },
                  ),
                  RaisedButton(
                      child: Text("戦績の追加"),
                      onPressed: () {
                        rank_point_list.add(rank_point);
                        print(rank_point_list);
                      }),
                ],
              ),
            ),
          ),
          Container(
            child: SimpleTimeSeriesChart.withSampleData(),
            height: 400,
          )
          //TODO: ListViewがおかしいので修正
          /*ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${rank_point_list[index]}"),
                //title: Text('aaa'),
              );
            },
          )*/
        ],
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
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text('ランク'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

//TODO: Chartの理解
class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
