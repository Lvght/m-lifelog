import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lifelog/components/last_week_barchart.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<ReactionDisposer>? _disposers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _disposers ??= [
      // reaction<bool>((_) => Provider.of<MasterStore>(context, listen: false).entriesChanged, (bool v) {}),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estatísticas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              'Semana passada',
              style: Theme.of(context).textTheme.headline6,
            ),
            LastWeekBarchart(),
          ],
        ),
      ),
    );
  }
}
