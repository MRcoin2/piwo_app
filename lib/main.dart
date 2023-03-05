import 'dart:typed_data';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:untitled/features/home/home_screen.dart';
import 'package:untitled/features/scan/scan_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: FlexThemeData.light(
      scheme: FlexScheme.espresso,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 9,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
    darkTheme: FlexThemeData.dark(
      scheme: FlexScheme.espresso,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
    themeMode: ThemeMode.system,
    initialRoute: '/',
    routes: {
      '/': (ctx) => Home(),
      ScanScreen.routeName: (ctx) => ScanScreen(),
    },
    onGenerateRoute: (settings) {
      print(settings.arguments);
      // if (settings.name == '/meal-detail') {
      //   return ...;
      // } else if (settings.name == '/something-else') {
      //   return ...;
      // }
      // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
    },
    onUnknownRoute: (settings) {
      return MaterialPageRoute(
        builder: (ctx) => Text("err, wrong route"),
      );
    },
  ));
}

