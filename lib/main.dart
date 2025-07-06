import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/shared_local_storage.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';
import 'package:halaqat_wasl_main_app/theme/app_theme.dart';
import 'package:halaqat_wasl_main_app/ui/auth/auth_gate_screen.dart';
import 'package:halaqat_wasl_main_app/ui/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/onboarding/onboarding_screen.dart';




void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await EasyLocalization.ensureInitialized();

  await SetupSupabase.setUpSupabase();
  await EasyLocalization.ensureInitialized();

  await InjectionContainer.setUp();

  await GetIt.I.allReady();


  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'AR')],
      path:'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // When the user entre the app first time goes to the onboarding screen, otherwise goes to auth screen
  final bool isFirstTime = GetIt.I.get<SharedLocalStorage>().sharedPreference!.getBool('isFirstTime') ?? true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: isFirstTime ? OnboardingScreen() : AuthGateScreen() ,
      ),
    );
  }
}
