import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';

class RequestRepo {
  static final _requestSupabase = SetupSupabase.sharedSupabase;

  static Future<void> insertRequestIntoDB({required RequestModel request}) async {
    await _requestSupabase.client.from('requests').insert(request.toMap());
  }
}