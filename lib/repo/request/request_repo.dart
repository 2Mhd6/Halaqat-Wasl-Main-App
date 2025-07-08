import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/model/charity_model/charity_model.dart';
import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';
import 'package:halaqat_wasl_main_app/model/driver_model/driver_model.dart';
import 'package:halaqat_wasl_main_app/model/hospital_model/hospital_model.dart';
import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/model/user_model/user_model.dart';
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
    final requestQuery = await _requestSupabase
        .from('requests')
        .select('*, users(*), charity(*), driver(*), hospital(*), complaint(*)')
        .eq('user_id', userId);

    log('$requestQuery');

    final requests = requestQuery.map((request) {
      return RequestModel(
        requestId: request['request_id'],
        userId: request['user_id'],
        charityId: request['charity_id'],
        hospitalId: request['hospital_id'],
        complaintId: request['complaint_id'],
        driverId: request['driver_id'],
        pickupLat: request['pick_up_lat'],
        pickupLong: request['pick_up_long'],
        destinationLat: request['destination_lat'],
        destinationLong: request['destination_long'],
        requestDate: DateTime.parse(request['request_date']),
        status: request['status'],
        note: request['note'],
        user: request['users'] != null
            ? UserModelMapper.fromMap(request['users'])
            : null,
        charity: request['charity'] != null
            ? CharityModelMapper.fromMap(request['charity'])
            : null,
        driver: request['driver'] != null
            ? DriverModelMapper.fromMap(request['driver'])
            : null,
        hospital: request['hospital'] != null
            ? HospitalModelMapper.fromMap(request['hospital'])
            : null,
        complaint: request['complaint'] != null
            ? ComplaintModelMapper.fromMap(request['complaint'])
            : null,
      );
    }).toList();

    log('i am in repo');
    return requests;
  }

  final currentUserData = GetIt.I.get<UserData>().user;

  //The insertRequest -> function is used to add a new request to the database.
  static Future<void> insertRequestIntoDB({
    required RequestModel request,
  }) async {
    await _requestSupabase.from('requests').insert(request.toMap());
  }

  static Future<void> cancelRequest(String requestId) async {
    await _requestSupabase
        .from('requests')
        .update({'status': 'cancelled'})
        .eq('request_id', requestId);
  }
}
