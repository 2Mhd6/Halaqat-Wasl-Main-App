import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/model/user_model/user_model.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileRepo {
  static final _supabaseClient = SetupSupabase.sharedSupabase;

  static Future<bool> updateUserDetailsInDB({required UserModel user}) async {
    try {
      await _supabaseClient.client
          .from('users')
          .update(user.toMap())
          .eq('user_id', user.userId);

      final currentUserData = GetIt.I.get<UserData>().user;

      if (user.email != currentUserData?.email) {
        // Update the email in the local user data
        await _supabaseClient.client.auth.updateUser(
          UserAttributes(email: user.email),
        );
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> updateUserPasswordInDB({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final userResponse = await _supabaseClient.client.auth.updateUser(
        UserAttributes(
          password: newPassword,
          email: _supabaseClient.client.auth.currentSession!.user.email,
        ),
      );
      return userResponse.user != null;
    } catch (error) {
      throw error.toString();
    }
  }
}
