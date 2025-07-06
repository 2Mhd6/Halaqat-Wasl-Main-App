import 'dart:math';
import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';

class ComplaintRepo {
  static final _supabase = SetupSupabase.sharedSupabase.client;

  // getComplaintByRequestId function -> This function fetches the complaint associated with a particular request.
  static Future<ComplaintModel?> getComplaintByRequestId(
    String requestId,
  ) async {
    final response = await _supabase
        .from('complaint') // "complaints"
        .select()
        .eq('request_id', requestId)
        .maybeSingle();

    if (response == null) return null;

    return ComplaintModelMapper.fromMap(response);
  }

  // insertComplaint Function: -> This function sends a new complaint to the database.
  static Future<void> insertComplaint(ComplaintModel complaint) async {
    await _supabase.from('complaint').insert(complaint.toMap());
  }

  // insertComplaintAndLinkToRequest Function -> inserts a new complaint into the complaints table and links its ID to the related request.
  static Future<void> insertComplaintAndLinkToRequest({
    required String requestId,
    required String complaintText,
    required String? userId,
    required String? hospitalId,
    required String? driverId,
    required String? charityId,
  }) async {
    //random complaint ID
    final complaintId = 'comp_${Random().nextInt(100000)}';

    //Create complaint model
    final complaint = ComplaintModel(
      complaintId: complaintId,
      requestId: requestId,
      userId: userId,
      hospitalId: hospitalId,
      driverId: driverId,
      charityId: charityId,
      complaint: complaintText,
      response: '',
      isActive: true,
    );

    // Insert into complaints table
    await _supabase.from('complaint').insert(complaint.toMap());

    // Link complaint ID to the corresponding request
    await _supabase
        .from('requests')
        .update({'complaint_id': complaintId})
        .eq('request_id', requestId);
  }
}
