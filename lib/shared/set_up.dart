import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/model/user_model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SetupSupabase {
  static final Supabase sharedSupabase = Supabase.instance;

  static Future<void> setUpSupabase() {
    return Supabase.initialize(
      url: dotenv.get('supabase_url'),
      anonKey: dotenv.get('supabase_key'),
    );
  }
}

class InjectionContainer {
  static void setUp() async {
    GetIt.I.registerSingleton<UserData>(UserData());
  }
}
