import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStorage {

  SharedPreferences? sharedPreference;
  
  Future<void> init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }
}