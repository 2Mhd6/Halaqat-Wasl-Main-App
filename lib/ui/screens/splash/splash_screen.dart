import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    
                    // If not first time, check if user is logged in
                    // Uncomment the following line if you have AuthGateScreen
                    // to replace with the AuthGateScreen navigation 

                      //  Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => AuthGateScreen()),
                      // );
                    

                    // Delete the following lines if you have AuthGateScreen
                    // and replace with the AuthGateScreen navigation
                    
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );

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
