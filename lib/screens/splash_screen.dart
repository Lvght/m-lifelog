import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lifelog/screens/database_error.dart';
import 'package:lifelog/screens/main_screen.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _loadData(BuildContext context) async {
    MasterStore _store = MasterStore();

    bool initializationSucceded = await _store.initializeDatabase();

    if (initializationSucceded) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Provider(
                create: (_) => _store,
                builder: (_, __) => const MainScreen(),
              )));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const DatabaseErrorScreen()));
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) => _loadData(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/res/full_logo_black.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
