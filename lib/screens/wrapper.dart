import 'package:flutter/material.dart';
import 'package:lifelog/screens/main_screen.dart';
import 'package:lifelog/screens/options_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lifelog/screens/statistics_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _index = 0;

  void _changeIndex(int v) => setState(() {
        _index = v;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _index,
          children: const [
            MainScreen(),
            StatisticsScreen(),
            OptionsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _changeIndex,
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_rounded),
                label: AppLocalizations.of(context)!.labelHomePage),
            BottomNavigationBarItem(
                icon: const Icon(Icons.stacked_bar_chart_rounded),
                label: AppLocalizations.of(context)!.labelStatsPage),
            BottomNavigationBarItem(
                icon: const Icon(Icons.menu_rounded),
                label: AppLocalizations.of(context)!.labelOptionsPage),
          ],
        ));
  }
}
