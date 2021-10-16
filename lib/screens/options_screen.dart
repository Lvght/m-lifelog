import 'package:flutter/material.dart';
import 'package:lifelog/helpers/database_helper.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Opções'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(
                'Fazer backup no Google Drive',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: Icon(Icons.backup_rounded,
                  color: Theme.of(context).colorScheme.secondary),
              onTap: () => DatabaseHelper.backupToGoogleDrive(),
            )
          ],
        ));
  }
}
