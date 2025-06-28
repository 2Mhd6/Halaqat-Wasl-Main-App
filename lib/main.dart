import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';
import 'package:halaqat_wasl_main_app/theme/app_theme.dart';
import 'package:halaqat_wasl_main_app/ui/screens/splash/splash_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: '.env');

  await SetupSupabase.setUpSupabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: SplashScreen(),
    );
  }
}