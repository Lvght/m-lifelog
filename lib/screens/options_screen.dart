import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    bool uSure = false;

    await showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!
                      .overwriteGDriveConfirmation),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            uSure = false;
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.cancel)),
                      TextButton(
                          onPressed: () {
                            uSure = true;
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.overwrite)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

    if (uSure) {
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        AppLocalizations.of(context)!.backupToGDriveInProgress),
                    const SizedBox(height: 16),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          });

      await Provider.of<MasterStore>(context, listen: false).closeDatabase();
      await DatabaseHelper.backupToGoogleDrive();
      await Provider.of<MasterStore>(context, listen: false)
          .initializeDatabase();

      _store.setIsLoggedIn(true);

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.backupToGDriveSuccessful),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  Future<void>? _restoreFromGoogleDriveCallback(BuildContext context) async {
    bool uSure = false;

    await showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!
                      .overwriteDeviceConfirmation),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            uSure = false;
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.cancel)),
                      TextButton(
                          onPressed: () {
                            uSure = true;
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.overwrite)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

    if (uSure) {
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.loadingGDriveData),
                    const SizedBox(height: 16),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          });

      await Provider.of<MasterStore>(context, listen: false).closeDatabase();
      final bool success = await DatabaseHelper.restoreFromGoogleDrive();

      if (success) {
        await Provider.of<MasterStore>(context, listen: false)
            .initializeDatabase();

        await Provider.of<MasterStore>(context, listen: false).reset();

        _store.setIsLoggedIn(true);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const SplashScreen()),
            (route) => false);
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(AppLocalizations.of(context)!.loadingGDriveDataFailed)));
      }
    }
  }

  Future<void>? _revokeGoogleLoginCallback() async {
    await DatabaseHelper.logoutFromGoogle();
    _store.setIsLoggedIn(false);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.googleLogout)));
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
          title: Text(AppLocalizations.of(context)!.labelOptionsPage),
        ),
        body: Observer(builder: (context) {
          return ListView(
            children: [
              if (_store.isLoggedIn)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.revokeGDriveLogin,
                      style: Theme.of(context).textTheme.bodyText2),
                  trailing: Icon(
                    Icons.logout_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onTap: _revokeGoogleLoginCallback,
                ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.backupToGDrive,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Icon(Icons.backup_rounded,
                    color: Theme.of(context).colorScheme.secondary),
                onTap: () => _backupToGoogleDriveCallback(context),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.restoreFromGDrive,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Icon(Icons.cloud_download_rounded,
                    color: Theme.of(context).colorScheme.secondary),
                onTap: () => _restoreFromGoogleDriveCallback(context),
              ),
              ListTile(
                title: Text(
                  Provider.of<MasterStore>(context, listen: false).darkTheme
                      ? AppLocalizations.of(context)!.disableDarkTheme
                      : AppLocalizations.of(context)!.activateDarkTheme,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Icon(Icons.dark_mode_rounded,
                    color: Theme.of(context).colorScheme.secondary),
                onTap: () async {
                  await Provider.of<MasterStore>(context, listen: false)
                      .setDarkTheme(
                          !Provider.of<MasterStore>(context, listen: false)
                              .darkTheme);
                },
              )
            ],
          );
        }));
  }
}
