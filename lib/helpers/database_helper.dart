import 'dart:io' show Directory, File, FileSystemEntity, IOSink;

import 'package:google_sign_in/google_sign_in.dart' as sign_in;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:lifelog/helpers/google_auth_helper.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<void> _onConfigure(Database db) async {
    // Adiciona suporte ao on_delete=cascade
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> _onCreate(Database db, int version) async {
    print('/!\\ Creating database...');
    await db
        .execute('CREATE TABLE Entries (id INTEGER PRIMARY KEY, title TEXT, '
            'content TEXT, feeling INT, created_at INT NOT NULL, image BLOB)');
  }

  static Future<Database?> initializeDatabase() async {
    Database _db = await openDatabase(
      join(await getDatabasesPath(), 'lifelog.db'),
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
    return _db;
  }

  static Future<drive.DriveApi?> _getDriveApi() async {
    sign_in.GoogleSignInAccount? account = await _loginToGoogleAccount();

    final authHeaders = await account?.authHeaders;

    if (authHeaders != null) {
      final authenticatedClient = GoogleAuthHelper(authHeaders);
      return drive.DriveApi(authenticatedClient);
    }
    return null;
  }

  static Future<sign_in.GoogleSignInAccount?> _loginToGoogleAccount() async {
    final sign_in.GoogleSignIn googleSignIn =
        sign_in.GoogleSignIn.standard(scopes: [drive.DriveApi.driveFileScope]);

    if (await googleSignIn.isSignedIn()) {
      // googleSignIn.disconnect();
    }

    return await googleSignIn.signIn();
  }

  static Future<bool>? backupToGoogleDrive() async {
    sign_in.GoogleSignInAccount? account = await _loginToGoogleAccount();

    if (account != null) {
      final authHeaders = await account.authHeaders;
      final authenticatedClient = GoogleAuthHelper(authHeaders);

      final driveAPI = drive.DriveApi(authenticatedClient);

      // Gets the database file
      final directoryPath = await getDatabasesPath();
      File database = File(join(directoryPath, 'lifelog.db'));

      drive.FileList fileList = await driveAPI.files.list(
        q: "mimeType = 'application/vnd.google-apps.folder' and name = 'lifelog'",
      );
      String? parentFolderId;
      if (fileList.files != null && fileList.files!.isNotEmpty) {
        parentFolderId = fileList.files!.first.id;
      } else {
        drive.File backupFolder = drive.File(
            name: 'lifelog', mimeType: 'application/vnd.google-apps.folder');

        drive.File createFolderResponse =
            await driveAPI.files.create(backupFolder);

        parentFolderId = createFolderResponse.id;
      }

      drive.File backupFile = drive.File(
          name: 'lifelog.db',
          parents: parentFolderId != null ? [parentFolderId] : null);

      drive.File createFileResponse = await driveAPI.files.create(backupFile,
          uploadMedia: drive.Media(database.openRead(), database.lengthSync()));

      if (createFileResponse.driveId != null) {
        return true;
      }
    }

    return false;
  }

  static Future<bool> restoreFromGoogleDrive() async {
    drive.DriveApi? api = await _getDriveApi();

    if (api != null) {
      String? latestBackupFileId;

      drive.FileList fileList = await api.files.list(
        q: "name = 'lifelog.db' and mimeType = 'application/octet-stream' and trashed = false",
        orderBy: 'createdTime',
      );

      if (fileList.files != null && fileList.files!.isNotEmpty) {
        fileList.files!.forEach((drive.File e) {
          print(e.id);
        });

        drive.File latestBackup = fileList.files!.last;
        latestBackupFileId = latestBackup.id;
      }

      if (latestBackupFileId != null) {
        // latestBackupFileId = '1PqgNU-k7xEmm4Pbmk11Ww_ZJOCfjc17g';
        //drive.Media backupFile = await api.files.get(latestBackupFileId, downloadOptions: drive.DownloadOptions.fullMedia);

        print('Seeking $latestBackupFileId');
        Object fileGenericObject = await api.files.get(
          latestBackupFileId,
          downloadOptions: drive.DownloadOptions.fullMedia,
        );

        drive.Media media = fileGenericObject as drive.Media;
        // print((await media.stream.).toString());

        String databasePath = join(await getDatabasesPath(), 'lifelog.db');
        IOSink databaseFileSink = File(databasePath).openWrite();

        await databaseFileSink.addStream(media.stream);
        await databaseFileSink.flush();
        await databaseFileSink.close();

        // databaseFile.writeAsBytes(media.stream as Uint8List);
      }
    }

    return false;
  }
}
