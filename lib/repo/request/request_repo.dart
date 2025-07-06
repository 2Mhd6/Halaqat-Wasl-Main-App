import 'dart:developer';
import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';

class RequestRepo {
  static final _requestSupabase = SetupSupabase.sharedSupabase.client;

//getRequestById function -> Searches for a single request by requestId
  static Future<RequestModel?> getRequestById(String requestId) async {
    try {
      final response = await _requestSupabase
          .from('requests')
          .select()
          .eq('request_id', requestId)
          .maybeSingle();

      if (response == null) {
        log('Request not found for ID: $requestId');
        return null;
      }

      final model = RequestModelMapper.fromMap(response);
      log('Request fetched successfully: ${model.toJson()}');
      return model;
    } catch (e) {
      log('Error in getRequestById: $e');
      return null;
    }
  }
//getAllRequests function -> fetches all requests from the requests table
  static Future<List<RequestModel>> getAllRequests() async {

    final userId = _requestSupabase.auth.currentUser!.id;
    final response = await _requestSupabase.from('requests').select()
        .eq('user_id', userId);

    return (response as List)
        .map((map) => RequestModelMapper.fromMap(map))
        .toList();
  }

//The insertRequest -> function is used to add a new request to the database.
  static Future<void> insertRequestIntoDB({required RequestModel request}) async {
    await _requestSupabase.from('requests').insert(request.toMap());
  }
}
