import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lifelog/models/entry.dart';
import 'package:lifelog/models/weekday_average.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

class LastWeekBarchart extends StatelessWidget {
  const LastWeekBarchart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<WeekdayAverage>>(
        future: _last7DaysStats(context),
        builder: (BuildContext context,
            AsyncSnapshot<List<WeekdayAverage>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.done:
            default:
              if (snapshot.hasData && !snapshot.hasError) {
                return _getBarChart(context, snapshot.data!);
              }

              return const Text('Algo deu errado.');
          }
        },
      ),
    ));
  }

  Widget _getBarChart(BuildContext context, List<WeekdayAverage> averages) {
    return LineChart(
      LineChartData(
        maxY: 4,
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: <FlSpot>[
              FlSpot(0, 1),
              FlSpot(1, 2),
              FlSpot(2, 3),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<WeekdayAverage>> _last7DaysStats(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));

    final List<Entry> entries =
        await Provider.of<MasterStore>(context, listen: false)
            .getLast7DaysEntries();

    print('Received ${entries.length} in top level');

    Map<int, List<Entry>> entriesByWeekDay = {};
    List<WeekdayAverage> result = [];

    for (int i = 1; i <= 7; i++) {
      List<Entry> entriesForToday =
          entries.where((element) => element.createdAt.weekday == i).toList();

      if (entriesForToday.isNotEmpty) {
        int totalMood = 0;
        int totalOfEntriesThatHaveMood = 0;
        double average = 0.0;

        for (Entry e in entriesForToday) {
          if (e.sentiment != null) {
            totalMood += e.sentiment!;
            totalOfEntriesThatHaveMood++;
          }
        }

        average = totalMood / totalOfEntriesThatHaveMood;

        result.add(WeekdayAverage(entriesForToday.first.createdAt, average));
      }

      entriesByWeekDay.addAll({
        i: entries.where((element) => element.createdAt.weekday == i).toList()
      });
    }

    return [];
  }
}
