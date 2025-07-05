

import 'package:halaqat_wasl_main_app/shared/set_up.dart'; 

class ProfileRepo {
  static final  _supabase = SetupSupabase.sharedSupabase;

  static Future signOut() async {
    try {
      await _supabase.client.auth.signOut();
    } catch (error) {
      throw error.toString();
    }
  }
  

}