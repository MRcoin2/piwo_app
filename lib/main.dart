import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/database_communication/add_beer_screen.dart';
import 'package:untitled/features/database_communication/utils.dart';
import 'package:untitled/features/friends/add_friend_screen.dart';
import 'package:untitled/features/friends/friend_requests.dart';
import 'package:untitled/features/home/home_screen.dart';
import 'package:untitled/features/scan/scan_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/features/settings/edit_user_info_screen.dart';
import 'package:untitled/features/settings/settings_screen.dart';
import 'package:untitled/features/user_login/sign_up_screen.dart';
import 'package:untitled/features/user_login/splash_screen.dart';
import 'features/collection/collection_screen.dart';
import 'features/user_login/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase with persistence enabled
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(MaterialApp(
    theme: FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary: Color(0xff9b4d1f),
        primaryContainer: Color(0xffd7b7a5),
        secondary: Color(0xffdb823f),
        secondaryContainer: Color(0xfff0cdb2),
        tertiary: Color(0xffc17345),
        tertiaryContainer: Color(0xfff0ded3),
        appBarColor: Color(0xfff0cdb2),
        error: Color(0xffb00020),
      ),
      usedColors: 2,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 9,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    ),
    darkTheme: FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: Color(0xff9b4d1f),
        primaryContainer: Color(0xff3e1e0c),
        secondary: Color(0xffeda85e),
        secondaryContainer: Color(0xff66483e),
        tertiary: Color(0xffc17345),
        tertiaryContainer: Color(0xff54311c),
        appBarColor: Color(0xff66483e),
        error: Color(0xffcf6679),
      ),
      usedColors: 2,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    ),
    themeMode: ThemeMode.system,
    initialRoute: '/',
    routes: {'/': (ctx) =>  SplashScreen(),
      AuthScreen.routeName: (ctx) =>  AuthScreen(),
      HomeScreen.routeName: (ctx) =>  HomeScreen(),
      ScanScreen.routeName: (ctx) =>  ScanScreen(),
      SignUpScreen.routeName: (ctx) =>  SignUpScreen(),
      EditProfilePage.routeName:(ctx)=> EditProfilePage(),
      AddFriendPage.routeName:(ctx)=> AddFriendPage(),
      FriendRequestsPage.routeName:(ctx)=> FriendRequestsPage(),
      SettingsScreen.routeName:(ctx)=> SettingsScreen(),
      CollectionScreen.routeName:(ctx)=> CollectionScreen(),
    },
    onGenerateRoute: (settings) {
      debugPrint(settings.arguments.toString());
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
    },
    onUnknownRoute: (settings) {
      return MaterialPageRoute(
        builder: (ctx) => const Text("err, wrong route"),
      );
    },
  ));
}

