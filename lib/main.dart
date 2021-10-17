import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifelog/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Lifelog());
}

class Lifelog extends StatelessWidget {
  Lifelog({Key? key}) : super(key: key);

  final _lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: Color(0xFF069AE0),
      background: Color(0xFFFEFEFE),
      brightness: Brightness.light,
      error: Colors.red,
      onBackground: Color(0xFF191919),
      onError: Colors.white,
      onPrimary: Color(0xFFFEFEFE),
      onSecondary: Color(0xFFFEFEFE),
      onSurface: Color(0xFF191919),
      primaryVariant: Color(0xFF191919),
      secondary: Color(0xFF191919),
      secondaryVariant: Color(0xFF191919),
      surface: Color(0xFFFEFEFE),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF191919),
      centerTitle: true,
      elevation: 0,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF191919)),

    // ANCHOR: Theme for elevated buttons.
    /*elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF191919)),
                foregroundColor: MaterialStateProperty.all(const Color(0xFF191919)),
              ),
            ),*/

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.roboto(
        color: const Color(0xA0FEFEFE),
        fontSize: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: const Color(0xFF191919),
      focusColor: Colors.white,
    ),

    // ANCHOR: Theme for TextButtons.
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(const Color(0xFF191919)),
      ),
    ),

    // ANCHOR: Theme for FABs.
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF191919),
    ),

    // ANCHOR: Text theme.
    textTheme: TextTheme(
      bodyText1: GoogleFonts.montserrat(fontSize: 16),
      bodyText2: GoogleFonts.roboto(fontSize: 16),
      subtitle1:
          GoogleFonts.roboto(color: const Color(0xFFFEFEFE), fontSize: 16),
      subtitle2:
          GoogleFonts.roboto(color: const Color(0xFF191919), fontSize: 16),
      headline5: GoogleFonts.montserrat(
          fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -.5),
      headline6: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );

  final _darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: Color(0xFF069AE0),
      background: Color(0xFF191919),
      brightness: Brightness.dark,
      error: Colors.red,
      onBackground: Color(0xFFFEFEFE),
      onError: Colors.white,
      onPrimary: Color(0xFF191919),
      onSecondary: Color(0xFF191919),
      onSurface: Color(0xFFFEFEFE),
      primaryVariant: Color(0xFFFEFEFE),
      secondary: Color(0xFFFEFEFE),
      secondaryVariant: Color(0xFFFEFEFE),
      surface: Color(0xFF191919),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF191919),
      centerTitle: true,
      elevation: 0,
    ),
    scaffoldBackgroundColor: const Color(0xFF202020),

    // ANCHOR: Theme for elevated buttons.
    /*elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF191919)),
                foregroundColor: MaterialStateProperty.all(const Color(0xFF191919)),
              ),
            ),*/

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.roboto(
        color: const Color(0xA0191919),
        fontSize: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: const Color(0xFFFEFEFE),
      focusColor: Colors.white,
    ),

    // ANCHOR: Theme for TextButtons.
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(const Color(0xFFFEFEFE)),
      ),
    ),

    // ANCHOR: Theme for FABs.
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFEFEFE),
    ),

    // ANCHOR: Text theme.
    textTheme: TextTheme(
      bodyText1: GoogleFonts.montserrat(fontSize: 16),
      bodyText2: GoogleFonts.roboto(fontSize: 16),
      subtitle1:
          GoogleFonts.roboto(color: const Color(0xFF191919), fontSize: 16),
      subtitle2:
          GoogleFonts.roboto(color: const Color(0xFFFEFEFE), fontSize: 16),
      headline5: GoogleFonts.montserrat(
          fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -.5),
      headline6: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MasterStore _store = MasterStore();
    return Provider(
        create: (_) => _store,
        builder: (context, _) {
          return Observer(builder: (context) {
            return MaterialApp(
              title: 'Lifelog',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en', ''), Locale('pt', '')],
              theme: _store.darkTheme ? _darkTheme : _lightTheme,
              home: const SplashScreen(),
            );
          });
        });
  }
}
