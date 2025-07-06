import 'package:halaqat_wasl_main_app/shared/set_up.dart';

class DriverRepo {
  static final _supabase = SetupSupabase.sharedSupabase.client;

  // Get driver name by ID
  static Future<String?> getDriverNameById(String driverId) async {
    try {
      final response = await _supabase
          .from('driver')
          .select('full_name')
          .eq('driver_id', driverId)
          .maybeSingle();

      if (response == null) return null;

      return response['name'] as String;
    } catch (e) {
      print('Error fetching driver name: $e');
      return null;
    }
  }
}
