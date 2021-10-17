import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lifelog/helpers/database_helper.dart';
import 'package:lifelog/screens/splash_screen.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:lifelog/state/options_screen_store.dart';
import 'package:provider/provider.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  final _store = OptionsScreenStore();

  Future<void>? _backupToGoogleDriveCallback(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Carregando para o Google Drive. Aguarde...'),
                  SizedBox(height: 16),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });

    await Provider.of<MasterStore>(context, listen: false).closeDatabase();
    await DatabaseHelper.backupToGoogleDrive();
    await Provider.of<MasterStore>(context, listen: false).initializeDatabase();

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Backup feito!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<void>? _restoreFromGoogleDriveCallback(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                      'Carregando backup mais recente do Google Drive. Aguarde...'),
                  SizedBox(height: 16),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });

    await Provider.of<MasterStore>(context, listen: false).closeDatabase();
    await DatabaseHelper.restoreFromGoogleDrive();
    await Provider.of<MasterStore>(context, listen: false).initializeDatabase();
    await Provider.of<MasterStore>(context, listen: false).getContent();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SplashScreen()),
        (route) => false);
  }

  Future<void>? _revokeGoogleLoginCallback() async {
    await DatabaseHelper.logoutFromGoogle();
    _store.setIsLoggedIn(false);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você saiu da sua conta Google')));
  }

  @override
  void initState() {
    super.initState();
    DatabaseHelper.isLoggedIn().then((value) => _store.setIsLoggedIn(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Opções'),
        ),
        body: Observer(builder: (context) {
          return ListView(
            children: [
              if (_store.isLoggedIn)
                ListTile(
                  title: Text('Revogar login na conta Google atual',
                      style: Theme.of(context).textTheme.bodyText2),
                  trailing: Icon(
                    Icons.logout_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onTap: _revokeGoogleLoginCallback,
                ),
              ListTile(
                title: Text(
                  'Fazer backup no Google Drive',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Icon(Icons.backup_rounded,
                    color: Theme.of(context).colorScheme.secondary),
                onTap: () => _backupToGoogleDriveCallback(context),
              ),
              ListTile(
                title: Text(
                  'Restaurar backup do Google Drive',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Icon(Icons.cloud_download_rounded,
                    color: Theme.of(context).colorScheme.secondary),
                onTap: () => _restoreFromGoogleDriveCallback(context),
              )
            ],
          );
        }));
  }
}
