import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/ui/screens/onboard/onboard_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/splash/bloc/splash_bloc.dart';
import 'package:logging/logging.dart';
    var logger = Logger('Splash Screen');

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc()..add(SplashStartedEvent()),
      child: Builder(
        builder: (context) {
          logger.info('Splash Screen build');
    return BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashEndedState) {
                logger.info('Move from Splash');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnBoardScreen()),
                );
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: context.getWidth(),
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
