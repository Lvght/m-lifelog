import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifelog/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Lifelog());
}

class Lifelog extends StatelessWidget {
  const Lifelog({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => MasterStore(),
        builder: (context, _) {
          return MaterialApp(
            title: 'Lifelog',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', ''), Locale('pt', '')],
            theme: ThemeData(
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
                  foregroundColor:
                      MaterialStateProperty.all(const Color(0xFF191919)),
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
                subtitle1: GoogleFonts.roboto(
                    color: const Color(0xFFFEFEFE), fontSize: 16),
                subtitle2: GoogleFonts.roboto(
                    color: const Color(0xFF191919), fontSize: 16),
                headline5: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -.5),
                headline6: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            home: const SplashScreen(),
          );
        });
  }
}
