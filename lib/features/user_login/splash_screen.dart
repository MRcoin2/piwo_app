import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/home/home_screen.dart';
import 'package:untitled/features/user_login/login_screen.dart';

void checkUserSignIn(BuildContext context) {
  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    // If there is a signed-in user, navigate to the HomeScreen
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  } else {
    // If there is no signed-in user, navigate to the SignInScreen
    Navigator.pushReplacementNamed(context, AuthScreen.routeName);

  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkUserSignIn(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),//TODO create app loading animation
      ),
    );
  }
}
