import 'package:halaqat_wasl_main_app/model/user_model/user_model.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';

class UserOperationRepo {

  static final _userOperationSupabase = SetupSupabase.sharedSupabase;

  static Future<void> insertUserDetailsIntoDB({required UserModel user}) async {
   try{
     return await _userOperationSupabase.client.from('users').insert(user.toMap());
   }catch(error){
    throw error.toString();
   }
  }

  static Future<UserModel> getUserDetailsFromDB() async {
    final String userId = _userOperationSupabase.client.auth.currentSession!.user.id;
    final Map<String,dynamic> query = await _userOperationSupabase.client.from('users').select().eq('user_id', userId).single();
    return UserModelMapper.fromMap(query);
  }
}