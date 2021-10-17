import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lifelog/screens/database_error.dart';
import 'package:lifelog/screens/wrapper.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _loadData(BuildContext context) async {
    bool initializationSucceded =
        await Provider.of<MasterStore>(context, listen: false)
            .initializeDatabase();

    if (initializationSucceded) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Provider(
                create: (_) =>
                    (_) => Provider.of<MasterStore>(context, listen: false),
                builder: (_, __) => const Wrapper(),
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
