import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/screens/home/home_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/login_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/ui/screens/onboard/onboard_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget { 
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      // Create SplashBloc and trigger SplashStartedEvent to start
      create: (context) => SplashBloc()..add(SplashStartedEvent()),
      child: Builder(
        builder: (context) {
          return BlocListener<SplashBloc, SplashState>(

            // Listen to SplashBloc state changes
            listener: (context, state) async {
              if (state is SplashEndedState) {

                // Get shared preferences to check if first time or logged in
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                final bool firstTime = prefs.getBool('firstTime') ?? true;
                if (context.mounted) {

                  // If first time, navigate to OnBoardScreen
                  if (firstTime) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OnBoardScreen()),
                    );
                  } else {
                    
                   // If NOT first time, navigate to ProfileScreen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                    return;
                    final isLoggedin = false;
                    // ignore: dead_code
                    if (isLoggedin) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  }
                }
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: context.getWidth(),// Width according to the screen width
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
