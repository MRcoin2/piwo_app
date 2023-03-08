import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/database_communication/add_beer_screen.dart';
import 'package:untitled/features/database_communication/utils.dart';
import 'package:untitled/features/home/home_screen.dart';
import 'package:untitled/features/scan/scan_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/features/user_login/sign_up_screen.dart';
import 'package:untitled/features/user_login/splash_screen.dart';
import 'features/user_login/login_screen.dart';
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
    routes: {'/': (ctx) =>  SplashScreen(),
      AuthScreen.routeName: (ctx) =>  AuthScreen(),
      HomeScreen.routeName: (ctx) =>  HomeScreen(),
      ScanScreen.routeName: (ctx) =>  ScanScreen(),
      SignUpScreen.routeName: (ctx) =>  SignUpScreen(),

      // AddBeerScreen.routeName: (ctx) => AddBeerScreen(),
    },
    onGenerateRoute: (settings) {
      debugPrint(settings.arguments as String?);
      if (settings.name == AddBeerScreen.routeName) {
        final args = settings.arguments as BeerData;
        return MaterialPageRoute(
          builder: (context) {
            return AddBeerScreen(
              barcodeId: args.barcodeId,
            );
          },
        );
      }else if(settings.name == AddBeerScreen.routeName){}
      assert(false, 'Need to implement ${settings.name}');
      return null;
        // return ...;
      // } else if (settings.name == '/something-else') {
      //   return ...;
      // }
      // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
    },
    onUnknownRoute: (settings) {
      return MaterialPageRoute(
        builder: (ctx) => const Text("err, wrong route"),
      );
    },
  ));
}

